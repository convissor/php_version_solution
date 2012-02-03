#! /bin/bash

# vvvvvvvvvvvvvvvvvvvvvvvvv
# USER CONFIGURATION (UC)

# The destination directory.
prefix=/usr/local

# ^^^^^^^^^^^^^^^^^^^^^^^^^

branch=`git branch | grep -E '^\*'`
if [[ $branch == "* master" ]] ; then
	echo "ERROR: don't install from the 'master' branch."
	echo "Check out your custom branch, then run install."
	exit 1
fi

sudo cp -ir lib/phpvs $prefix/lib
sudo chmod 755 $prefix/lib/phpvs
sudo chmod 644 $prefix/lib/phpvs/*

sudo cp -i bin/* $prefix/bin
sudo chmod 665 $prefix/bin/phpcm
sudo chmod 755 $prefix/bin/peart $prefix/bin/phput $prefix/bin/php[it]
