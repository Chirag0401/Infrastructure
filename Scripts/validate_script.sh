#!/bin/bash
Responce="$(curl localhost:4500/api)"
if [[ "$Responce" == *"404"* ]]; 
then echo "App is running"; 
else echo "App is Not running"; 
fi