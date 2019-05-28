#!/bin/bash

#Execute scibasic for each Object found in the scibasicobjec.sof

#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation1
source $scripts/config/params 

execlocation=$scripts/executables/
#Create bias sof with python

#Change to data location
cd $ESOREX_OUTPUT_DIR

#Variables
recipe=muse_create_sky
filesof=sky.sof
logfile=sky.log



#numberobject=$(grep OBJECT $SOF_LOCATION$filesof | wc -l)

#for numob in Object*; do
for numob in Object*; do
    #If directoy doesnt exist create it
#    if [ ! -d Object$numob ]; then
#        mkdir Object$numob
#    fi
    echo $numob
    cd $numob
    #Needed to do this for the sof
    source $scripts/config/params 
    #
    python3 $execlocation'createskysof.py'
   
    #Excecute scibasic. For this has to change exorex outpuit dir
    ESOREX_OUTPUT_DIR=$(pwd)
    likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $filesof
    #sky2
    echo $(pwd)
    python3 $execlocation'createsky2.py'
    
    #sky3 #Why not same sof and do sky_2.so
    echo -e $(pwd)'/SKY_CONTINUUM_zero.fits\tSKY_CONTINUUM\n' >> $filesof
    
    likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $filesof
    
    python3 $execlocation'createsky4.py'

#Rename ouput
#    mv IMAGE_FOV_0001.fits ../IMAGE_FOV_$numob'.fits'
#    mv PIXTABLE_REDUCED_0001.fits ../PIXTABLE_REDUCED_$numob'.fits'
#    mv DATACUBE_FINAL.fits ../DATACUBE_$numob'.fits'

    cd ..
done

# For each Object create a file if it doesnt exist and 
#change teh poutput folder and rename each putout to object one. 


#likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
