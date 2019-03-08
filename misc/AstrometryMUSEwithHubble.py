

# In[2]:


from astropy.io import fits
from mpdaf.obj import Image, WCS


# In[11]:


### get offset between MUSE and HST ###
imahst = Image('firstdraftwcsfixedicrshubblef606wimg.fits')
cont = Image('CousingI.fits')
ima2hst = cont.adjust_coordinates(imahst)

ima2hst.info()

