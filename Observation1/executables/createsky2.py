#!/usr/bin/env python3
""" Program to create a list of the sky  sof """
from astropy.io import fits
import glob, os
import shutil

sky_cont_hdu = fits.open('SKY_CONTINUUM.fits',checksum=True)
sky_cont = sky_cont_hdu[1].data
for i in range(len(sky_cont)): sky_cont[i][1] = 0.
sky_cont_hdu[1].data = sky_cont
sky_cont_hdu.writeto('SKY_CONTINUUM_zero.fits',overwrite = True,checksum=True)

