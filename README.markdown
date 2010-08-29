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

## Odds and Ends

There is a `_droplet.png` file in the repository you can use to create your own droplet icons.

If someone has a higher-resolution of that image, please let me know.

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
