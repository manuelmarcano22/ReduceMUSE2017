#!/bin/bash

#Twilight


#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation1
source $scripts/config/params 


#Create bias sof with python
python3 createscibasicobjectsof.py

#Change to data location
cd $DATA_LOCATION

#Variables
recipe=muse_scibasic
filesof=scibasic.sof
logfile=scibasic.log

#likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
