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

# bdcfg configures the general build options for the IBS build system.
#
# IBS is the LibraNext Integrated Build System. It's primary purpose is to
# 	enable easier building of the LibraNix operating system and ensuring all
#	team members are using the same options.


# Set the IBS version

IBSV="`cat /opt/ibs/release`"

# Let's do some setup and cleanup work quick
# Check for existing config temporary directory. If it doesn't exist, create it. If it exists, cleanup the "bldcfg" section.

if [ -d "/tmp/ibs/config/bldcfg" ]
then
	rm -rf /tmp/ibs/config/bldcfg
	rm -rf /tmp/ibs/config/bldcfg
	rm -rf /tmp/ibs/config/bldcfg
	mkdir /tmp/ibs/config/bldcfg
	touch /tmp/ibs/config/bldcfg/menuselectBC1
fi

if [ ! -d "/tmp/ibs/config/bldcfg" ]
then
	mkdir /tmp/ibs/config/bldcfg
	touch /tmp/ibs/config/bldcfg/menuselectBC1
fi

# Lets create the main menu

dialog --backtitle "IBS Integrated Build System version `echo $IBSV`" --title "Choose item to configure" --menu "What option would you like to configure?" 25 75 15 \
"setproj" "Set Project Directory" \
"setthread" "Set number of CPU threads to use" \
"setlog" "Set logging level" \
"setpfx" "Set default prefix" \
"return" "Return to configuration path menu"\
> /tmp/ibs/config/bldcfg/menuselectBC1

if [ `cat /tmp/ibs/config/bldcfg/menuselectBC1` == return ];then
	bash /opt/ibs/ibs-config.sh --quiet
	exit 0
elif [ `cat /tmp/ibs/config/bldcfg/menuselectBC1` == setproj ];then
	# Set up the project directory for the build. Required for the next options.
	# The user can have multiple project directories so IBS can handle multiple builds easily.
	# Essentially the user simply has to set the directory here. Since all these options and
	# most of the other configuration options are stored per-project, they will be auto-loaded.
	# This ensures that all builds stay clean and use the correct configuration. Note that only
	# one instance of IBS should be run at a time.
	exit 0
elif [ `cat /tmp/ibs/config/bldcfg/menuselectBC1` == setthread ];then
	# This option sets the maximum number of CPU threads to be used when compiling. AKA sets MAKEFLAGS -j option.
	# The default value will be 1 thread so that without user intervention the default setting will work on any CPU.
	# This value should be 1*<Number of cores>*<number of hyperthreads (INTEL ONLY) per core>
	# Core2Duo processors report HT support but do not support hyperthreading.
	# Some programs/test suites can by default run multiple threads even on single core due to wait times. This value
	# is used directly in calculating an approriate thread count for those scenarios.
	exit 0
elif [ `cat /tmp/ibs/config/bldcfg/menuselectBC1` == setlog ];then
	# This option sets the logging level. By default IBS will log all configuration options and some errors.
	# The user can set to log all output (where supported).
	exit 0
elif [ `cat /tmp/ibs/config/bldcfg/menuselectBC1` == setpfx ];then
	# This option sets the default installation prefix. Note that some applications have overrides.
	exit 0
fi

exit 0