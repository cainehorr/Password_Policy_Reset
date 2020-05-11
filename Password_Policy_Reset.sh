#!/bin/sh

##############################################################################
#
# SCRIPT FILENAME:
# 	Password_Policy_Reset.sh
#
# DESCRIPTION:
#	Shell script for resetting macOS Password Policies back to factory
#	defaults.
#
# CHANGE LOG:
#	v1.0 - 2020-05-11
#		Written by Caine Hörr
#		https://github.com/cainehorr
#			* Initial Script Creation
#
##############################################################################

##############################################################################
#
# MIT License
#
# Copyright (c) 2020 Caine Hörr
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to 
# deal in the Software without restriction, including without limitation the 
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#
##############################################################################

main(){
	Run_as_Root
	Acquire_Logged_In_User
	Reset_Password_Policies
}

Run_as_Root(){
	# Check for admin/root permissions
	if [ "$(/usr/bin/id -u)" != "0" ]; then
		/bin/echo "Script must be run as root"
		exit 1
	fi
}

Acquire_Logged_In_User(){
	# Acquire currently logged in user
	currentUser=$(/usr/bin/stat -f "%Su" "/dev/console")
	echo "Currently logged in user: ${currentUser}"
}


Reset_Password_Policies(){
	# Resets to factory settings
	sudo pwpolicy -u ${currentUser} -clearaccountpolicies	
}

main

exit
