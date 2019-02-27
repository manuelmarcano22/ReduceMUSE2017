#!/usr/bin/env python3
""" Program to create a list of the dark sof """

from astropy.io import fits
import glob, os
from lookcriteria import lookfits



datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']


sof = 'dark.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits')


files.extend(filesout)
lista = []


lookfits(files,lista,'ESO DPR TYPE','DARK','DARK')
lookfits(files,lista,'PIPEFILE','MASTER_BIAS.fits','MASTER_BIAS')
lookfits(files,lista,'HIERARCH ESO PRO CATG','BADPIX_TABLE','BADPIX_TABLE')


  
    

print(lista[-1])

soffile = '{}{}'.format(sofdir,sof)
sof = open(soffile, 'w')        
for i in lista:
    #sof.write(str(i)+'\tBIAS\n')
    sof.write(str(i))


sof.close()
