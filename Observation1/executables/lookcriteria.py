#!/usr/bin/env python3
"""Function that looks for specifici fits file using a creiteia and create sof"""

from astropy.io import fits
import os

def lookfits(filelist,listtoappend,headerfield,headername,namesof):
    """for specific field in the header and if it matches appendes it to the list"""
    for f in filelist:
        hd = fits.getheader(f)
        try:
            if hd[headerfield]==headername:
                dirpath = os.path.dirname(f)
                name = os.path.basename(f)
                typename = namesof
                fullname = '{}/{}\t{}\n'.format(dirpath,name,typename)
                listtoappend.append(fullname)
        except:
            pass


