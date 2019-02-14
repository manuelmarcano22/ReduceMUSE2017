#!/usr/bin/env python3
""" Program to create a list of the wavelegnth cal """

from astropy.io import fits
import glob, os
from lookcriteria import lookfits



datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']


sof = 'wavecal.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits')


files.extend(filesout)
lista = []


lookfits(files,lista,'ESO DPR TYPE','WAVE','ARC')

lookfits(files,lista,'PIPEFILE','MASTER_BIAS.fits','MASTER_BIAS')

lookfits(files,lista,'PIPEFILE','TRACE_TABLE.fits','TRACE_TABLE')

lookfits(files,lista,'HIERARCH ESO PRO CATG','LINE_CATALOG','LINE_CATALOG')


  
    

print(lista[-1])

soffile = '{}{}'.format(sofdir,sof)
sof = open(soffile, 'w')        
for i in lista:
    #sof.write(str(i)+'\tBIAS\n')
    sof.write(str(i))


sof.close()
