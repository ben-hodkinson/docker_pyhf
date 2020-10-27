## You need pyhf in a usable image?

This image is based on the latest ATLAS AnalysisBase base image. It is intended to be used within a RECAST setup running statistical fits using pyhf.

Upon running the image, you can do 

```source /home/atlas/release_setup.sh```

to setup the analysis release. This will give you access to handy things like `xrdcp` to get your inputs from some grid space (don't forget to setup a Kerberos ticket for access rights).

The image provides `python` 

```
python3 --version
Python 3.6.8
```

and `pyhf` including all available backends as well as XML I/O utils:

```
pyhf --version
pyhf, version 0.5.3
```

