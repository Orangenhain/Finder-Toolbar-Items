-- Based loosely on http://snippets.dzone.com/posts/show/1037

-- script was clicked
on run
	tell application "Finder"
		if selection is {} then
			set finderSelection to {folder of the front window as alias}
		else
			set finderSelection to selection as alias list
		end if
	end tell
	
	xcode(finderSelection)
end run

-- script was drag-and-dropped onto
on open (theList)
	xcode(theList)
end open

on xcode(listOfAliases)
	set myCount to 0
	repeat with singleItem in listOfAliases
		if _xcode(singleItem) then
			set myCount to myCount + 1
		end if
	end repeat
	
	if myCount is equal to 0 then
		tell application "Finder"
			set aFolderAlias to folder of the front window as alias
		end tell
		_xcode(aFolderAlias)
	end if
end xcode

on _xcode(singleAlias)
	try
		do shell script "/usr/bin/env zsh -c 'cd \"" & POSIX path of singleAlias & "\" && open *.xcodeproj'"
		# do shell script "/bin/sleep 1"
		# tell application "Xcode"
		# 	activate
		# end tell
	on error
		return false
	end try
	return true
end _xcode
