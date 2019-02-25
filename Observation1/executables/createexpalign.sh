#!/bin/bash

#Exp Align


#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation1
source $scripts/config/params 



#Change to data location
cd $ESOREX_OUTPUT_DIR

#Variables
recipe=muse_exp_align
filesof=expalign.sof
logfile=expalign.log

echo '' > $SOF_LOCATION'expalign.sof' 

echo $(pwd)

#Create sof
#ls IMAGE_FOV_Object* > $SOF_LOCATION$filesof
for i in  $(ls IMAGE_FOV_Object*) ; do
    echo $(readlink -f $i) IMAGE_FOV >> $SOF_LOCATION'expalign.sof';
done


likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
