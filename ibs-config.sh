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

# IBS-Config is a shell script to aid in configuring the IBS build process.
#
# IBS is the LibraNext Integrated Build System. It's primary purpose is to
# 	enable easier building of the LibraNix operating system and ensuring all
#	team members are using the same options.


# First we have to include the newt-display library

source newt-display.sh

# Set the IBS version

IBSV="`cat /opt/ibs/release`"

# Let's do some setup and cleanup work quick
# Check for existing config temporary directory. If it doesn't exist, create it. If it exists, cleanup the "config" section.

if [ -d "/tmp/ibs/config" ]
then
	rm -rf /tmp/ibs/config/*
	rm -rf /tmp/ibs/config/*.*
	rm -rf /tmp/ibs/config/.*
	touch /tmp/ibs/config/menuselectC1
fi

if [ ! -d "/tmp/ibs/config" ]
then
	mkdir /tmp/ibs/config
	touch /tmp/ibs/config/menuselectC1
fi

# Now we need to build the main menu that allows the user to select what configuration path to follow

whiptail --backtitle "IBS Integrated Build System version `echo $IBSV`" --title "Choose Configuration Path" --menu "What configuration path would you like to follow?" 25 75 15 \
"ibscfg" "Configure IBS" \
"genbdcfg" "General Build Configuration Options" \
"srccfg" "Configure source acquisition" \
"bsyscfg" "Configure build system for base system build" \
"isocfg" "Configure build system for ISO build" \
"prgcfg" "Configure build system for individual program build" \
"rpmpcfg" "Configure build system for RPM package build" \
"return" "Return to Main Menu" \
2> /tmp/ibs/config/menuselectC1

if [ `cat /tmp/ibs/config/menuselectC1` == return ];then
	bash /opt/ibs/ibs.sh --quiet
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == ibscfg ];then
	bash /opt/ibs/config-ibscfg.sh
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == genbdcfg ];then
	bash /opt/ibs/config/bdcfg.sh
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == srccfg ];then
	bash /opt/ibs/config/srccfg.sh
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == bsyscfg ];then
	bash /opt/ibs/config/bsyscfg.sh
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == isocfg ];then
	bash /opt/ibs/config/isocfg.sh
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == prgcfg ];then
	bash /opt/ibs/config/prgcfg.sh
	exit 0
elif [ `cat /tmp/ibs/config/menuselectC1` == rpmcfg ];then
	bash /opt/ibs.config/rpmcfg.sh
	exit 0
fi

exit 0