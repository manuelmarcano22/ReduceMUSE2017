#!/usr/bin/env python3
""" Program to create a list of the BIAS """

from astropy.io import fits
import glob, os




datadirectory = os.environ['DATA_LOCATION']
productdir = os.environ['SOF_LOCATION']
biassof = 'bias.sof'


files = glob.glob(datadirectory+'/*fits')

bias = []
for f in files:
    hd = fits.getheader(f)
    try:
        if hd['ESO DPR TYPE']=='BIAS':
            dirpath = os.path.dirname(f)
            name = os.path.basename(f)
            fullname = '{}/{}'.format(dirpath,name)
            bias.append(fullname)
    except:
        pass
    

print(bias[0])

soffile = '{}{}'.format(productdir,biassof)
sof = open(soffile, 'w')        
for i in bias:
    sof.write(str(i)+'\tBIAS\n')


sof.close()
