#! /bin/bash

# vvvvvvvvvvvvvvvvvvvvvvvvv
# USER CONFIGURATION (UC)

# The destination directory.
prefix=/usr/local

# ^^^^^^^^^^^^^^^^^^^^^^^^^


sudo cp -ir lib/phpvs $prefix/lib
sudo chmod 755 $prefix/lib/phpvs
sudo chmod 644 $prefix/lib/phpvs/*

sudo cp -i bin/* $prefix/bin
sudo chmod 665 $prefix/bin/phpcm
sudo chmod 755 $prefix/bin/peart $prefix/bin/php[it]
