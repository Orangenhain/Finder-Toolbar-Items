(*
 *
 *		AppleScript which handles input and opens Terminal
 *
 *		Modified from Marc Liyanage
 *			http://www.entropy.ch/software/applescript/
 *		and Jonathan Austin
 *			http://forums.macosxhints.com/showthread.php?p=426240#post426240 
 *		
 *)


-- ============
-- = Defaults =
-- ============

-- Make a new Terminal shell (0) or use the frontmost one 
property makeNew : 0
-- When creating Terminal shells, create new tabs (0) rather than new windows 
property useTabs : 1


-- =================
-- = Even Handlers =
-- =================

on open untitled theObject
	-- This is triggered when the application icon is clicked
	
	set commandKeyDown to (call method "cmdKeyDown" of class "StartupController") as boolean
	if (commandKeyDown) then
		set useTabs to 0
	end if

	set optionKeyDown to (call method "optKeyDown" of class "StartupController") as boolean
	if (optionKeyDown) then
		set makeNew to 1
	end if

	-- Get the path of the frontmost Finder window
	tell application "Finder"
		try
			set thisFolder to (the target of the front window) as alias
		on error
			set thisFolder to startup disk
		end try
	end tell
	
	my openTerm(thisFolder)	
	
	quit
	
end open untitled


on open theObject
	-- This is triggered when some documents/folders are dropped on the icon
	set commandKeyDown to (call method "cmdKeyDown" of class "StartupController") as boolean
	if (commandKeyDown) then
		set useTabs to 0
	end if

	set optionKeyDown to (call method "optKeyDown" of class "StartupController") as boolean
	if (optionKeyDown) then
		set makeNew to 1
	end if

	repeat with thisItem in theObject
		my openTerm(thisItem)
	end repeat

	quit
end open


-- =================
-- = Open Terminal =
-- =================
on openTerm(theItem)
	
	-- Get the POSIX path of the item (dropped or Finder selection)
	set thePath to POSIX path of theItem
	-- display dialog thePath
	
	-- Strip out file name to keep just directory (`dirname` like in Applescript)
	repeat until thePath ends with "/"
		set thePath to text 1 thru -2 of thePath
	end repeat
	-- display dialog thePath
	
	-- Set the command line to run
	set cdCommand to "cd " & quoted form of thePath
	
	-- `cd` to there in Terminal
	tell application "Terminal"
		activate
		
		if makeNew is equal to 0 then
			-- Always make a new shell
			
			if useTabs is equal to 0 then
				-- Make a new tab
				tell application "System Events" to tell process "Terminal" to ¬
					keystroke "t" using command down
					-- NB: There _must_ be a better way to open a new tab
				do script cdCommand  in window 1
			else
				-- Make a new window
				do script cdCommand
			end if
		
		
		else
		 	-- Use the frontmost shell
		
			set windowCount to (count of the windows)
			if windowCount is greater than 0 then
				-- Check that there is at least a window
				
				if window 1 is not busy then
					-- Then check that that frontmost window is not busy
					-- If it is not busy, run the command there
					do script cdCommand in window 1
				else
					-- If it is busy run the command in a new window or tab depending on settings
					if useTabs is equal to 0 then
						-- Make a new tab
						tell application "System Events" to tell process "Terminal" to ¬
							keystroke "t" using command down
							-- NB: There _must_ be a better way to open a new tab
						do script cdCommand  in window 1
					else
						-- Make a new window
						do script cdCommand
					end if
				end if

			else				
				-- There's no window, so just create one
				do script cdCommand
			
			end if	
		
		end if

	end tell
end openTerm
