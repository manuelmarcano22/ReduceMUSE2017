#!/usr/bin/env python3
""" Program to create a list of the sky  sof """
from astropy.io import fits
import glob, os
import shutil


shutil.copy('SKY_CONTINUUM_zero.fits','SKY_CONTINUUM.fits')
hdu=fits.open('SKY_LINES.fits',checksum=True)
data=hdu[1].data

lines_to_keep=[i for i,sky_line in enumerate(data) if (sky_line[0][:2] == 'O2' or sky_line[0][:2] == 'OH')]
data=data[lines_to_keep]

hdu[1].data = data
hdu.writeto('SKY_LINES.fits', overwrite = True, checksum=True)

