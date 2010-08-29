-- Based loosely on http://snippets.dzone.com/posts/show/1037

-- script was clicked
on run
	tell application "Finder"
		set finderSelection to quoted form of POSIX path of (the folder of the front window as alias)
		#		set finderSelection to folder of the front window as string
	end tell
	
	gitgui(finderSelection)
end run

on gitgui(listOfAliases)
	--	tell application "Terminal"
	--		activate
	--		do script "cd " & listOfAliases & "; /usr/local/git/bin/git gui; exit;"
	--	end tell
	do shell script "screen -dmS git-gui-droplet bash -c 'cd " & listOfAliases & "; /usr/local/bin/gitx'"
	do shell script "/bin/sleep 0.25"
	tell application "GitX"
		activate
	end tell
end gitgui
