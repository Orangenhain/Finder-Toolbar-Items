-- cd to the current finder window folder in iTerm. Or drag a folder onto this script to cd to that folder in iTerm.
-- found this script in the comments of this article: http://www.macosxhints.com/article.php?story=20050924210643297

-- Instructions for use:
-- paste this script into Script Editor and save as an application to ~/Library/Scripts/Applications/Finder/cd to in iTerm
-- run via the AppleScript Menu item (http://www.apple.com/applescript/scriptmenu/)
-- Or better yet, Control-click and drag it to the top of a finder window so it appears in every finder window.
-- Activate it by clicking on it or dragging a folder onto it.

-- Another nice touch is to give the saved script the same icon as iTerm.
-- To do this, in the finder, Get info (Command-I) of both iTerm and this saved script.
-- Click the iTerm icon (it will highlight blue) and copy it by pressing Comand-C.
-- Click on this script's icon and paste by pressing Command-V.

-- Another way to give it the same icon as iTerm is to save the script as an application bundle (instead of an application),
--  then copy the icon by entering these commands in iTerm:
-- $ cd ~/Library/Scripts/Applications/Finder/cd\ to\ in\ iTerm.app/Contents/Resources/
-- $ rm droplet.icns
-- $ cp /Applications/iTerm.app/Contents/Resources/iTerm.icns droplet.icns
-- $ touch ~/Library/Scripts/Applications/Finder/cd\ to\ in\ iTerm.app

-- script was opened by click in toolbar
on run
	tell application "Finder"
		try
			if selection is {} then
				set currFolder to (folder of the front window as string)
			else
				set currFolder to ((first item of (selection as list)) as string)
				if not (currFolder ends with ":") then
					set x to the offset of ":" in (the reverse of every character of currFolder) as string
					set currFolder to (characters 1 thru -(x) of currFolder) as string
				end if
			end if
		on error
			set currFolder to (path to desktop folder as string)
		end try
	end tell
	CD_to(currFolder, false)
end run

-- script run by draging file/folder to icon
on open (theList)
	set newWindow to false
	repeat with thePath in theList
		set thePath to thePath as string
		if not (thePath ends with ":") then
			set x to the offset of ":" in (the reverse of every character of thePath) as string
			set thePath to (characters 1 thru -(x) of thePath) as string
		end if
		CD_to(thePath, newWindow)
		set newWindow to true -- create window for any other files/folders
	end repeat
	return
end open

-- cd to the desired directory in iterm
on CD_to(theDir, newWindow)
	set theDir to quoted form of POSIX path of theDir as string
	tell application "iTerm"
		activate
		delay 1
		-- talk to the first terminal
		try
			set myterm to the current terminal
		on error
			set myterm to (make new terminal)
		end try
		
		tell myterm
			try
				-- launch a default shell in a new tab in the same terminal 
				launch session "Default Session"
			on error
				display dialog "There was an error creating a new tab in iTerm." buttons {"OK"}
			end try
			tell the last session
				try
					-- cd to the finder window
					write text "cd " & theDir
				on error
					display dialog "There was an error cding to the finder window." buttons {"OK"}
				end try
			end tell
		end tell
	end tell
end CD_to
