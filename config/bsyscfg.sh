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

# bsyscfg configures the IBS build system for a complete base system build.
#
# IBS is the LibraNext Integrated Build System. It's primary purpose is to
# 	enable easier building of the LibraNix operating system and ensuring all
#	team members are using the same options.


# First we have to include the newt-display library

source newt-display.sh

# Set the IBS version

IBSV="`cat /opt/ibs/release`"