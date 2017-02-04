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

# IBS is the main user-facing wrapper script.
#
# IBS is the LibraNext Integrated Build System. It's primary purpose is to
# 	enable easier building of the LibraNix operating system and ensuring all
#	team members are using the same options.



# First we have to include the newt-display library

source newt-display.sh

# Set the IBS version

IBSV="0.1"

# Since we may want to launch the menu without a splash screen, let's set a command line option.

if [ -z $1 ]
then
	# Let's make a splash screen

	wInfoBox "IBS Integrated Build System version `echo $IBSV`" "Startup" "IBS Integrated Build System\n(C) Copyright 2017 Keagan Winterthieme." 8 50 clear
fi

# Let's do some setup and cleanup work quick
# Check for existing IBS temporary directory. If it doesn't exist, create it. If it exists, cleanup the "main" section.

if [ -d "/tmp/ibs" ]
then
	rm -rf /tmp/ibs/main
	mkdir /tmp/ibs/main
	touch /tmp/ibs/main/menuselect01
fi

if [ ! -d "/tmp/ibs" ]
then
	mkdir /tmp/ibs
	mkdir /tmp/ibs/main
	touch /tmp/ibs/main/menuselect01
fi

if [ -z $1 ]
then
	sleep 3s
fi

whiptail --backtitle "IBS Integrated Build System version `echo $IBSV`" --title "Choose Action" --menu "What would you like to do?" 25 75 15 \
"about" "About IBS" \
"config" "Open the build configurator" \
"build" "Open the build system" \
"wizard" "Open the system installation wizard" \
"iso" "Open the ISO generation wizard" \
"exit" "Exit IBS" \
2> /tmp/ibs/main/menuselect01

if [ `cat /tmp/ibs/main/menuselect01` == exit ];then
	exit 0
elif [ `cat /tmp/ibs/main/menuselect01` == about ];then
	wMsgBox "IBS Integrated Build System version `echo $IBSV`" "About IBS" "IBS version `echo $IBSV`, (C) 2017 Keagan Winterthieme.\nIBS is designed to simplify and unify\nthe buildling and development of the\nLibraNix Operating System.\nSuggestions and bug reports can be sent to\nKeagan Winterthieme <hopefullifetwo@gmail.com>" 12 53 clear
	bash ibs.sh --quiet
	exit 0
elif [ `cat /tmp/ibs/main/menuselect01` == config ];then
	bash ibs-config.sh
	exit 0
elif [ `cat /tmp/ibs/main/menuselect01` == build ];then
	wInfoBox "IBS Integrated Biuld System version `echo $IBSV`" "Error" "Function not implemented yet" 7 40
	sleep 2s
	bash ibs.sh --quiet
	exit 0
elif [ `cat /tmp/ibs/main/menuselect01` == wizard ];then
	wInfoBox "IBS Integrated Biuld System version `echo $IBSV`" "Error" "Function not implemented yet" 7 40
	sleep 2s
	bash ibs.sh --quiet
	exit 0
elif [ `cat /tmp/ibs/main/menuselect01` == iso ];then
	echo ""
	exit 0
fi

exit 0