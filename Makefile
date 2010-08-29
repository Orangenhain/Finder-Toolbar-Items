# config
DROPLET_DIR := finder_toolbar_items
SCRIPT_SUFFIX := applescript
ICON_SUFFIX := icns

SOURCES := $(wildcard *.$(SCRIPT_SUFFIX))
DEPS := $(patsubst %.$(SCRIPT_SUFFIX), $(DROPLET_DIR)/%.app, $(SOURCES))

all: $(DEPS)

# $< evaluates to first dependency
# $? evaulates to dependencies more recent than the target
$(DROPLET_DIR)/%.app: %.$(SCRIPT_SUFFIX) %.$(ICON_SUFFIX)
	@if [ ! -d $(DROPLET_DIR) ]; then mkdir $(DROPLET_DIR); fi
	@# @echo "changed: $?"
	@if [[ $(words $?) -ne 1 || "$(suffix $(firstword $?))" != ".$(ICON_SUFFIX)" ]]; then \
		make droplet DROPLET=$< && make droplet-icon DROPLET=$<; \
	else \
		make droplet-icon DROPLET=$< ICON_ONLY=1; \
	fi

$(DROPLET_DIR)/%.app: %.$(SCRIPT_SUFFIX)
	@if [ ! -d $(DROPLET_DIR) ]; then mkdir $(DROPLET_DIR); fi
	@make droplet DROPLET=$< NO_ICON=1

TARGET_BASE := $(shell basename $(DROPLET) .$(SCRIPT_SUFFIX))
TARGET_TEMP := $(addsuffix .app, $(TARGET_BASE)_)
TARGET := $(addsuffix .app, $(TARGET_BASE))
TARGET_TEMP_DIR := $(DROPLET_DIR)/$(TARGET_TEMP)
TARGET_DIR := $(DROPLET_DIR)/$(TARGET)
droplet:
	@[[ "x$$DROPLET" != "x" ]] && true
	@echo "> creating droplet $(TARGET)"
	@rm -rf $(TARGET_DIR)
	@osacompile -x -a i386 -o $(TARGET_TEMP_DIR) $(DROPLET) 2>/dev/null
	@if [[ $(NO_ICON) -eq 1 ]]; then ditto $(TARGET_TEMP_DIR) $(TARGET_DIR); rm -rf $(TARGET_TEMP_DIR); fi

droplet-icon:
	@[[ "x$$DROPLET" != "x" ]] && true
	@[[ $(ICON_ONLY) -eq 1 ]] && echo "> setting icon for droplet $(TARGET)" || echo "  . setting icon"
	@if [ ! -d $(TARGET_TEMP_DIR) ]; then ditto $(TARGET_DIR) $(TARGET_TEMP_DIR); fi
	@cp $(addsuffix .icns, $(TARGET_BASE)) $(TARGET_TEMP_DIR)/Contents/Resources/droplet.icns
	@ditto $(TARGET_TEMP_DIR) $(TARGET_DIR)
	@rm -rf $(TARGET_TEMP_DIR)
	@# @SetFile -a C $(TARGET_DIR)
	@touch $(TARGET_DIR)

%.app: $(DROPLET_DIR)/$%.app
	@true

.DEFAULT:
	@if [[ MAKELEVEL -eq 1 ]]; then echo "working on: $@"; make $(DROPLET_DIR)/$@.app; fi

