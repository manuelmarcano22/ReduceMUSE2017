#!/usr/bin/env python3
""" Program to create a list of the scipost sof sof """

from astropy.io import fits
import glob, os
from lookcriteria import lookfits



datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']
cwd = os.getcwd()

sof = 'scipostobject.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits',recursive=False)
fileshere = glob.glob(cwd+'/*fits')

files.extend(filesout)
files.extend(fileshere)
lista = []


lookfits(files,lista,'HIERARCH ESO PRO CATG','PIXTABLE_OBJECT','PIXTABLE_OBJECT')
lookfits(files,lista,'HIERARCH ESO PRO CATG','EXTINCT_TABLE','EXTINCT_TABLE')
lookfits(files,lista,'HIERARCH ESO PRO CATG','STD_RESPONSE','STD_RESPONSE')
lookfits(files,lista,'HIERARCH ESO PRO CATG','STD_TELLURIC','STD_TELLURIC')
lookfits(files,lista,'HIERARCH ESO PRO CATG','ASTROMETRY_WCS','ASTROMETRY_WCS')
lookfits(files,lista,'HIERARCH ESO PRO CATG','LSF_PROFILE','LSF_PROFILE')
lookfits(files,lista,'HIERARCH ESO PRO CATG','FILTER_LIST','FILTER_LIST')



  
    

soffile = '{}/{}'.format(cwd,sof)
sof = open(soffile, 'w')        
for i in lista:
    #sof.write(str(i)+'\tBIAS\n')
    sof.write(str(i))


sof.close()
