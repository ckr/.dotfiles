#!/bin/bash

RUN=$(osascript <<EOF
try
	tell application "Plex Media Server"
		quit
	end tell
	delay 5
	tell application "Plex Media Server" to activate
on error errorMessage number errorNumber
	log ("errorMessage: " & errorMessage & ", errorNumber: " & errorNumber)
end try
EOF)

echo $RUN