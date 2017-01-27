#!/bin/bash

# (C) Copyright 2017 Keagan Winterthieme <hopefullifetwo@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# newt-display.sh is a library designed to make using whiptail easier in bash.
#
# IBS is the LibraNext Integrated Build System. It's primary purpose is to
# 	enable easier building of the LibraNix operating system and ensuring all
#	team members are using the same options.



# First we hve to check what terminal we are using. Whiptail/newt has a bug that prevents the --infobox option from working correctly in xterm.

if [ $TERM == xterm  ]
then
	WHIPBUG=1
else
	WHIPBUG=""
fi

# Next we want to set a few functions to make drawing windows easier.


# Function wInfoBox expects arguments in order: backtitle, title, text for box, height of dialog, width of dialog.
function wInfoBox() {

if [ -n $WHIPBUG ]
then
	WHIPCMD="TERM=v220 whiptail"
else
	WHIPCMD="whiptail"
fi

if [ -z $6 ]
then
	clear
fi

$WHIPCMD --backtitle $1 --title $2 --infobox $3 $4 $5

}