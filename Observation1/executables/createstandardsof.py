#!/usr/bin/env python3
""" Program to create a list of the STD standard sof """

from astropy.io import fits
import glob, os
from lookcriteria import lookfits



datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']


sof = 'standard.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits')


files.extend(filesout)
lista = []

#PIXTSABLE_STD

lookfits(files,lista,'HIERARCH ESO PRO CATG','PIXTABLE_STD','PIXTABLE_STD')

lookfits(files,lista,'HIERARCH ESO PRO CATG','EXTINCT_TABLE','EXTINCT_TABLE')
lookfits(files,lista,'HIERARCH ESO PRO CATG','STD_FLUX_TABLE','STD_FLUX_TABLE')
lookfits(files,lista,'HIERARCH ESO PRO CATG','FILTER_LIST','FILTER_LIST')




  
    

print(lista[-1])

soffile = '{}{}'.format(sofdir,sof)
sof = open(soffile, 'w')        
for i in lista:
    #sof.write(str(i)+'\tBIAS\n')
    sof.write(str(i))


sof.close()
