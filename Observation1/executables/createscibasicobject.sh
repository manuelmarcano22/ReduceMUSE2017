#!/bin/bash

#Execute scibasic for each Object found in the scibasicobjec.sof

#Souce Params file with enviroment variables
scripts=/home/mmarcano/Documents/ReduceMUSE2017/Observation1
source $scripts/config/params 

#Create bias sof with python
#python3 createscibasicobjectsof.py

#Change to data location
cd $ESOREX_OUTPUT_DIR

#Variables
recipe=muse_scibasic
filesof=scibasicobject.sof
logfile=scibasic.log



numberobject=$(grep OBJECT $SOF_LOCATION$filesof | wc -l)

for numob in $(seq 1 $numberobject); do
    #If directoy doesnt exist create it
    if [ ! -d Object$numob ]; then
        mkdir Object$numob
    fi
    cd Object$numob
    #Comment all the Object and then uncomment the one I want. Probable better ways
    # of doint it but i works. 
    commentline 1,$numberobject $SOF_LOCATION$filesof scibasicobject$numob'.sof'
    uncommentlineinplace $numob scibasicobject$numob'.sof'
    
    #Excecute scibasic. For this has to change exorex outpuit dir
    ESOREX_OUTPUT_DIR=$(pwd)
    likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe scibasicobject$numob'.sof'
    cd ..
done

# For each Object create a file if it doesnt exist and 
#change teh poutput folder and rename each putout to object one. 


#likwid-pin -c 0-23 esorex --recipe-config=$RECIPE_CONFIG/$recipe'.rc' --log-file=$logfile  $recipe $SOF_LOCATION$filesof
