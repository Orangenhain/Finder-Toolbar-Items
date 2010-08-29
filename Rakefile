  DROPLET_DIR = "finder_toolbar_items"
  ICON_SUFFIX = "icns"
SCRIPT_SUFFIX = "applescript"

SOURCES = FileList["*.#{SCRIPT_SUFFIX}"]
 CUSTOM = FileList["*.rake"]

class Rake::FileTask
  def outdated_prerequisites
    @prerequisites.select { |n| application[n, @scope].timestamp > self.timestamp}
  end
end

def _isDroplet? (dir)
  File.exists?("#{dir}/Contents/Resources/droplet.icns")
end

def let_type (dir)
  _isDroplet?(dir) ? "droplet" : "applet"
end

def create_droplet(task, custom_icon=true)
  verbose false

  mkdir(File.dirname(task.name)) unless File.directory?(File.dirname(task.name))
  rm_rf task.name
  temp_dir=File.join(File.dirname(task.name), File.basename(task.name, File.extname(task.name)) + "_.app")
  `osacompile -x -a i386 -o "#{temp_dir}" "#{task.sources.first}" 2>/dev/null`
  puts "> creating #{let_type(temp_dir)}: #{File.basename task.name}"
  unless custom_icon
    `ditto "#{temp_dir}" "#{task.name}"`
    rm_rf temp_dir
  end
end

def set_droplet_icon(task, first_icon_change=true)
  temp_dir=File.join(File.dirname(task.name), File.basename(task.name, File.extname(task.name)) + "_.app")
  puts first_icon_change ? "  . setting icon" : "> setting icon for #{let_type(temp_dir)} #{File.basename task.name}"
  verbose false

  `ditto "#{task.name}" "#{temp_dir}"` unless File.directory?(temp_dir)
  cp File.basename(task.name, File.extname(task.name))+".#{ICON_SUFFIX}", temp_dir + "/Contents/Resources/#{let_type(temp_dir)}.icns"
  `ditto "#{temp_dir}" "#{task.name}"`
  rm_rf temp_dir
  touch task.name
end

rule( /^#{Regexp.escape(DROPLET_DIR)}\/.*\.app/ => [
    proc { |targ| targ.sub(%r{^#{DROPLET_DIR}/(.*)\.app}, '\1.'+SCRIPT_SUFFIX) },
    proc { |targ| targ.sub(%r{^#{DROPLET_DIR}/(.*)\.app}, '\1.'+ICON_SUFFIX) }
  ]) do |t|
  # puts t.investigation
  outdated = t.outdated_prerequisites
  if (outdated.length == 1) and (File.extname(outdated.first) == ".#{ICON_SUFFIX}")
    set_droplet_icon(t, false)
  else
    create_droplet(t)
    set_droplet_icon(t)
  end
end

rule(/^#{Regexp.escape(DROPLET_DIR)}\/.*\.app/ => [
    proc { |targ| targ.sub(%r{^#{DROPLET_DIR}/(.*)\.app}, '\1.'+SCRIPT_SUFFIX) }
  ]) do |t|
  create_droplet(t, false)
end

desc "build all available Finder toolbar items"
task :default do
  # called for no command line arguments
  SOURCES.each { |file| Rake::Task[File.join(DROPLET_DIR, file.sub(/\.#{Regexp.escape(SCRIPT_SUFFIX)}$/, '.app'))].invoke }

  CUSTOM.each do |rakefile|
    puts "> calling custom rakefile: #{rakefile}"
    `rake -f \"#{rakefile}\" build_droplet[\"#{DROPLET_DIR}\"]`
    puts "  . " + (($?.exitstatus == 0) ? "Success" : "FAIL [#{$?.exitstatus}]")
  end
end

rule(/.*/) do |t|
  # catch all ;; silence rake errors for unknown tasks
  # called when command line arguments are available (except for "default")
  ARGV.each do |arg|
    if arg =~ /.*\.app$/
      Rake::Task[File.join(DROPLET_DIR, arg)].invoke
    else
      Rake::Task[File.join(DROPLET_DIR, "#{arg}.app")].invoke if File.readable?("#{arg}.#{SCRIPT_SUFFIX}")
    end
  end
  
end
