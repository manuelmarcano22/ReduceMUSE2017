#!/usr/bin/env python3
""" Program to create a list of the --- sof """

from astropy.io import fits
import glob, os
from lookcriteria import lookfits



datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']


sof = 'expcombine.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits')


files.extend(filesout)
lista = []


lookfits(files,lista,'HIERARCH ESO PRO CATG','FILTER_LIST','FILTER_LIST')
lookfits(files,lista,'HIERARCH ESO PRO CATG','OFFSET_LIST','OFFSET_LIST')


print(lista[-1])

soffile = '{}{}'.format(sofdir,sof)
sof = open(soffile, 'w')        
for i in lista:
    sof.write(str(i))


sof.close()
