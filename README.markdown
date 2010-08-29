# Finder Toolbar Items

A collection of scripts & icons for Finder.app toolbar items (droplets & applets) and a Rakefile to produce the corresponding .app's.

## Installation

There are two ways to use this:

1. The I-Just-Want-To-Use-This way

    * download a pre-built archive from the [project's Github Downloads](http://github.com/Orangenhain/Finder-Toolbar-Items/downloads) page
    * unpack it to somewhere you feel comfortable with
    * drag & drop the files into your Finder's toolbar

2. The DIY way
    
    * clone the repository
    * `cd` to resulting directory & maybe modify the icons or scripts
    * run `rake` - this will result in all the toolbar items being built into a folder specified in the Rakefile
        
        You can also run `rake "toolbar item name"` to just get a specific item.
        
        Change the `DROPLET_DIR` constant in the Rakefile to have the resulting items be built into a directory of your choosing. The path is relative, i.e. using `../toolbar-items` is possible.

## Description of Items

### Open in GitX

Click on it, to open the directory of the current Finder window in GitX.

### Open in iTerm

Click it to open the directory of the currently selected file in an iTerm tab. If the selection is a directory, it will open the directory. If there is no selection, it will open the directory of the current Finder window.

Drop a directory on it have it open in an iTerm Tab.

### Open in {SubEthaEdit,TextMate}

Click to open current Finder selection in your favourite editor. If there is no selection, uses the directory of the current Finder window.

Also opens items dropped on it.

### Open in Xcode

Tired of looking for the `*.xcodeproj` file in a directory to open the project? Just click on the little item, and it will automatically open it for you.

If you have selected a folder, it will `cd` into it, and look there. Works with multiple selections.

Also works with dropped items.

TODO: If a file is selected, don't just ignore it. Instead, look for a .xcodeproj in its containing directory.

### Open Terminal Here

Quoting from the projects ReadMe:

    Clicking it opens a new Terminal window and changes directory to the location of the selected file/folder. Drag and dropping items on the icon opens one Terminal window per item.
    
    Holding down the ⌘ key opens tabs instead of windows.
    
    Holding down the ⌥ key changes directory in the front-most Terminal window instead of opening a new one. When the frontmost window is busy it opens a new window/tab (depending on the state of the ⌘ key)

Shows how to use modifier keys in scripts. If someone knows of an easier way, please let me know.

### Zsh glob select

Click on the toolbar item to get a window where you can enter a globbing-string (as in `*.h`). On Enter the script will select all files matching the glob in the current Finder window.

Modified version of the [lselect](http://anoved.net/software/lselect/) script. This will use Zsh to evaluate the globbing-string, for more information see <http://michael-prokop.at/blog/2008/12/24/mikas-advent-calendar-day-24-zsh-globbing/>.
Be careful with strings that will match files in subdirectories (e.g. `**/build(/)`), as the script will open the window necessary to see the match.

## Odds and Ends

There is a `_droplet.png` file in the repository you can use to create your own droplet icons.

If someone has a higher-resolution of that image, please let me know.

If there is no matching \_name\_.icns for a \_name\_.applescript, the Rakefile will leave the default icon in place.

## Credits & Contributors

* Jim DeVona -- <http://anoved.net/lselect.html>
* Simon Dorfman -- <http://snippets.dzone.com/posts/show/1037>
* JiHO -- [Github](http://github.com/jiho) , <http://maururu.net/2007/enhanced-open-terminal-here-for-leopard/>
* Marc Liyanage -- [Github](http://github.com/liyanage) , <http://www.entropy.ch/software/applescript/welcome.html>
* Henrik Nyh -- [Github](http://github.com/henrik) , <http://henrik.nyh.se>
* roddi -- [Github](http://github.com/roddi)
    
& probably a lot more people who helped, or whose code I found on the Internet.
Thank you all!
    
In case I missed someone who wants to be mentioned, just contact me, and it will be done.
If you don't want to see your name / code here, let me know and it will be removed.
