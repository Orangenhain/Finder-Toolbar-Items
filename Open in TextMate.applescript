-- Opens the currently selected Finder files, or else the current Finder window, in TextMate. Also handles dropped files and folders.

-- By Henrik Nyh <http://henrik.nyh.se>
-- Based loosely on http://snippets.dzone.com/posts/show/1037

-- script was clicked
on run
	tell application "Finder"
		if selection is {} then
			set finderSelection to folder of the front window as string
		else
			set finderSelection to selection as alias list
		end if
	end tell
	
	tm(finderSelection)
end run

-- script was drag-and-dropped onto
on open (theList)
	tm(theList)
end open

-- open in TextMate
on tm(listOfAliases)
	tell application "TextMate"
		open listOfAliases
		activate
	end tell
end tm
