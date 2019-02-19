#!/usr/bin/env python3
""" Program to create a list of the scibascid std sof """

from astropy.io import fits
import glob, os
from lookcriteria import lookfits



datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']


sof = 'scibasicstd.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits')


files.extend(filesout)
lista = []


#Do it for object or STD or Sky

todo = 'STD'
lookfits(files,lista,'ESO DPR TYPE',todo,todo)

#I dont have SKY or ASTROMETRY Field

lookfits(files,lista,'ESO DPR TYPE','FLAT,LAMP,ILLUM','ILLUM')

lookfits(files,lista,'PIPEFILE','MASTER_BIAS.fits','MASTER_BIAS')
lookfits(files,lista,'PIPEFILE','MASTER_DARK.fits','MASTER_DARK')
lookfits(files,lista,'PIPEFILE','MASTER_FLAT.fits','MASTER_FLAT')
lookfits(files,lista,'PIPEFILE','TRACE_TABLE.fits','TRACE_TABLE')
lookfits(files,lista,'PIPEFILE','WAVECAL_TABLE.fits','WAVECAL_TABLE')
lookfits(files,lista,'HIERARCH ESO PRO CATG','GEOMETRY_TABLE','GEOMETRY_TABLE')

lookfits(files,lista,'PIPEFILE','TWILIGHT_CUBE.fits','TWILIGHT_CUBE')

lookfits(files,lista,'HIERARCH ESO PRO CATG','BADPIX_TABLE','BADPIX_TABLE')




  
    

print(lista[-1])

soffile = '{}{}'.format(sofdir,sof)
sof = open(soffile, 'w')        
for i in lista:
    #sof.write(str(i)+'\tBIAS\n')
    sof.write(str(i))


sof.close()
