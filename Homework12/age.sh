#!/bin/bash

read -p "Enter year of birth: " year 

if [ $year -lt 2025 ] 
then
echo -e You are $((2025-year)) years old 
fi



read -p "Enter year of birth: " year 

if [ $year -lt 2020 ]
then
	echo -e You were $((2020-year)) years old in 2020
fi

read -p "Enter year of birth: " year
if [ $year -lt 2030 ]
then
	echo -e You will be $((2030-year)) years old in 2030
fi

