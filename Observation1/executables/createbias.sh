#!/bin/bash

#It creates a set-of-frames (sof) to use the muse_bias routine 
#and create a master bias


#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation1
source $scripts/config/params 


#Create bias sof with python
python3 createbiassof.py

#Change to data location
cd $DATA_LOCATION

#Variables
recipe=muse_bias
filesof=bias.sof
logfile=bias.log

taskset -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
