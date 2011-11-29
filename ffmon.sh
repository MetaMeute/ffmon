#!/bin/bash

# batctl o|cut -c1-17,19-27|tail -n +3

redraw() {
	clear
	draw_header
}

draw_header() {
	hostname=`hostname`
	mac=00:11:22:33:44:55
	datewidth=$[COLUMNS-32-3-17-3]
	printf "\033[1;1H\033[1;37m\033[44m%-32s | %17s | %*s\033[0m" "$hostname" "$mac" "$datewidth" "`date`"
}

draw_nodelist() {

}

resize() {
	COLUMNS=$(tput cols)
	LINES=$(tput lines)
	redraw
}

COLUMNS=0
LINES=0

resize

trap resize WINCH

clear

while true; do
	redraw
	sleep 1
done
