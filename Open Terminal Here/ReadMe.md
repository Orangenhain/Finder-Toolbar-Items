# Open Terminal Here

AppleScript application which opens a Terminal at the location of the front-most Finder window

## Usage

The application is well suited to be placed in the Finder's toolbar.

Clicking it opens a new Terminal window and changes directory to the location of the selected file/folder. Drag and dropping items on the icon opens one Terminal window per item.

Holding down the ⌘ key opens tabs instead of windows.

Holding down the ⌥ key changes directory in the front-most Terminal window instead of opening a new one. When the frontmost window is busy it opens a new window/tab (depending on the state of the ⌘ key)

## Todo

* Find a better way to open a new tab in Leopard's Terminal
* Correctly handle the case when both ⌥ and ⌘ are pressed. The code is ready for this but it currently produces a strange behavior. This is probably related to the System Events call. Fixing the point above should therefore fix this one
* Improve AppleScript code (use lists, less for loops, more functions, etc.)
* Remove identical paths when dropping several items on the application, so that only one shell is open per unique path
* Improve the icon so that it can be used at "Small Size" (not sure if it's possible)
* When this is ran while Terminal is not already running, an additional Terminal is opened. Suppress this.

# Sources and License

(c) 2007 JiHO jo.irisson (at) gmail.com GNU General Public License http://www.gnu.org/copyleft/gpl.html

Actually, code was kind of fetched all-around on the internet, so let us just say that everything is free and that you can do whatever you want with it as long as you continue sharing it. This **really** is for the greater good ;)

Original script and idea by [Marc Liyanage](http://www.entropy.ch/software/applescript/ "Marc Liyanage - Software - AppleScript")

Modified by [Jonathan Austin](http://forums.macosxhints.com/showthread.php?p=426240#post426240 "My leopard update for &quot;Open Terminal Here&quot; toolbar app - The macosxhints Forums") to use tabs in Leopard

Key-Down code from a marvelous [MacScripts example](http://bbs.applescript.net/viewtopic.php?id=19065 "MacScripter BBS | Applescript Forums / Customizing Application startup Behavior [Key down on launch]")

Icon by Henryk from [The Pug Automatic](http://henrik.nyh.se/2007/10/open-terminal-here-and-glob-select-in-leopard-finder "&#034;Open Terminal Here&#034; and lselect (glob select) in Leopard Finder &ndash;  The Pug Automatic")

# History of the original script

* 30-OCT-2001: Version 1.0, adapted from one of the example toolbar scripts
* 30-OCT-2001: Now handles embedded single quote characters in file names
* 30-OCT-2001: Now handles folders on volumes other than the startup volume
* 30-OCT-2001: Now handles click on icon in top-level (machine) window
* 31-OCT-2001: Now displays a nicer terminal window title, courtesy of Alain Content
* 11-NOV-2001: Now folders within application packages (.app directories) and has a new icon
* 12-NOV-2001: New properties to set terminal columns and rows as the Terminal does not use default settings
* 14-NOV-2001: Major change, now handles 8-bit characters in all shells, and quotes and spaces in tcsh
* 18-NOV-2001: Version 1.1: Rewrite, now uses a temporary file ~/.OpenTerminalHere to communicate the directory name between AppleScript and the shell because this is much more reliable for 8-bit characters
* 16-JAN-2006: Version 2.0: Rewrite, now uses "quoted form of" and "POSIX Path". This gets rid of Perl and temp files, but it no longer handles files instead of folders.
* 24-JAN-2007: Version 2.1: Integrated enhancements by Stephan Hradek, can again handle dropped files.
* 18-NOV-2007: Leopard Update. Detects busy tab and opens a new one if needed - Jonathan Austin
* 10-DEC-2007: New version with Terminal tabs, buzy window detection and use of Keyboard modifiers