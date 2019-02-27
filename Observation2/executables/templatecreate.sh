#!/bin/bash

#Twilight


#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation2
source $scripts/config/params 


#Create bias sof with python
python3 create---sof.py

#Change to data location
cd $DATA_LOCATION

#Variables
recipe=muse_
filesof=.sof
logfile=.log

#likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
