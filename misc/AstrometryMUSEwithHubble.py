

# In[2]:


from astropy.io import fits
from mpdaf.obj import Image, WCS, Cube


# In[11]:

cube = Cube('../Observation1/data/CopyDATACUBE_FINAL.fits')
imI = cube.get_band_image('Cousins_I')
imI.write('Cousing_ITryFOV.fits')


### get offset between MUSE and HST ###
imahst = Image('firstdraftwcsfixedicrshubblef606wimg.fits')
#cont = Image('CousingI.fits')
cont = Image('Cousing_ITryFOV.fits')
ima2hst = cont.adjust_coordinates(imahst)

ima2hst.write('FixedMUSEFOV.fits')
