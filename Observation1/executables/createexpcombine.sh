#!/bin/bash

#Execute expcombine with all PIXTABLE_REDUCED

#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation1
source $scripts/config/params 


#create sof with filter and off set list
python3 createexpcombinesof.py

#Change to data location
cd $ESOREX_OUTPUT_DIR

#Variables
recipe=muse_exp_combine
filesof=expcombine.sof
logfile=expcombine.log

for i in  $(ls PIXTABLE_REDUCED_Object*) ; do
    echo $(readlink -f $i) PIXTABLE_REDUCED >> $SOF_LOCATION$filesof;
done


likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
