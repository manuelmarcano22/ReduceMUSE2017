#!/bin/bash

#STD sceibasci


#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation2
source $scripts/config/params 


#Create bias sof with python
python3 createscibasicstdsof.py

#Change to data location
cd $DATA_LOCATION

#Variables
recipe=muse_scibasic
filesof=scibasicstd.sof
logfile=scibasicstd.log

likwid-pin -c 0-23 esorex  --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe --merge $SOF_LOCATION$filesof 
