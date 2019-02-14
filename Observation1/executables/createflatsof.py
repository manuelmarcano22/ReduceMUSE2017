#!/usr/bin/env python3
""" Program to create a list of the FLATs """

from astropy.io import fits
import glob, os




datadirectory = os.environ['DATA_LOCATION']
sofdir = os.environ['SOF_LOCATION']
outputdir = os.environ['ESOREX_OUTPUT_DIR']

sof = 'flat.sof'


files = glob.glob(datadirectory+'/*fits')
filesout = glob.glob(outputdir+'/*fits')

lista = []
for f in files:
    hd = fits.getheader(f)
    #Look for FLats
    try:
        if hd['ESO DPR TYPE']=='FLAT,LAMP':
            dirpath = os.path.dirname(f)
            name = os.path.basename(f)
            typename = 'FLAT'
            fullname = '{}/{}\t{}\n'.format(dirpath,name,typename)
            lista.append(fullname)
    except:
        pass

for f in filesout:
    hd = fits.getheader(f)
    #Look for master_bias
    try:
        if hd['PIPEFILE']=='MASTER_BIAS.fits':
            dirpath = os.path.dirname(f)
            name = os.path.basename(f)
            typename = 'MASTER_BIAS'
            fullname = '{}/{}\t{}\n'.format(dirpath,name,typename)
            lista.append(fullname)
    except:
        pass

   
    

print(lista[0])

soffile = '{}{}'.format(sofdir,sof)
sof = open(soffile, 'w')        
for i in lista:
    #sof.write(str(i)+'\tBIAS\n')
    sof.write(str(i))


sof.close()
