#!/bin/bash

# batctl o|cut -c1-17,19-27|tail -n +3

# Draw all the things!
redraw() {
	draw_header
	draw_nodelist
}

draw_header() {
	hostname=`hostname`
	mac=00:11:22:33:44:55
	datewidth=$[COLUMNS-32-3-17-3]
	printf "\033[1;1H\033[1;37m\033[44m%-32s | %17s | %*s\033[0m" "$hostname" "$mac" "$datewidth" "`date`"
}

draw_nodelist() {
	echo -en "\033[2;1H\033[1;33m"
	batctl o|cut -c1-17,19-27|tail -n +3
}

# Correct for changed lines/column values.
resize() {
	COLUMNS=$(tput cols)
	LINES=$(tput lines)
	redraw
}

cleanup() {
	rm -rf $MACDIR
}



### PROGRAM STARTS HERE
### ===================

## Initialize
## ----------
COLUMNS=0
LINES=0

# Create a temporary directory to keep track of all the connection data.
MACDIR=$(mktemp -d ffmon.XXXXXXXXXX)

resize
clear

## Program Loop
## ------------
while true; do
	redraw
	sleep 1
done



### TRAPS
### =====
trap cleanup EXIT

# Trap terminal window resize operations
trap resize WINCH
