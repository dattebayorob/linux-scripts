#!/bin/bash

checkUser(){
	if [ $USER != "root" ]; then
		echo "Run as root";
		exit;
	fi
	if [ -z $1 ]; then
		echo -e "You must type a user\nUsage: install.sh user";
		exit
	else
		if [ -z $(cat /etc/passwd | grep $1 | awk -F  ":" {'print $1'}) ]; then
			echo -e "User not found"
		fi
	fi
}