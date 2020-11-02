## You need pyhf in a usable image?

This image is based on the `pyhf/pyhf:v0.5.3` image. It is intended to be used within a RECAST setup running statistical fits using pyhf.

It allows to circumvent the `/usr/local/bin/pyhf` entrypoint in setups where you can't manually circumvent it through e.g:

```
docker run -it --rm --entrypoint "" pyhf/pyhf bash
```

This is, for example, currently the case with any RECAST implementation.

In addition, this image adds the `contrib` and `backends` requirements on top of the default `xmlio` requirements installed in the default pyhf/pyhf images.

Upon running the image, you can check the python version with

```
python3 --version
Python 3.7.9
```

and have `pyhf` available including all available backends as well as XML I/O utils:

```
pyhf --version
pyhf, version 0.5.3
```

