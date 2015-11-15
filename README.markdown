PHP Version Solution (phpvs)
============================

Overview
--------

PHP Version Solution is a set of bash scripts for compiling, installing,
and switching between multiple versions of PHP on *nix machines.

The package builds PHP from branch and trunk checkouts of git.php.net.

The installation routine also sets symlinks for `php` and `php-cgi` in
`/usr/bin` and `/usr/local/bin` to point to the most recently installed
version of PHP.  It also restarts lighttpd and Apache's httpd web
servers as appropriate.

To ensure each version of PHP is using the same environment, this system
uses a centralized set of php.ini files for most settings and a centralized
PEAR installation.

*EXPERIMENTAL:*  This package is experimental.  It is intended for use by
developers who know what they're doing.  It may do things you are not
expecting.  Read the source code to make sure it does what you want.  In
addition, this package is subject to change.  You take full responsibility
for using any part of this package.  In short, no belly aching.  Enjoy!


Scripts
-------

* phpvs:  the environment variables, aliases, and functions for the system
* phpcm:  configures and makes PHP for installation by phpi
* phpi:   installs the binary compiled by phpcm
* phprm:  removes a PHP installation under the current directory
* phpt:   runs .phpt tests via PHP's run-tests.php
* peart:  runs .phpt tests via PEAR's run-tests
* phput:  runs PHPUnit


Installation
------------

* Clone this package from GitHub then create a branch to store your settings.

        git clone git://github.com/convissor/php_version_solution.git
        cd php_version_solution
        git checkout -b custom

* Check out php-src from PHP's repository.  Below is an example.

        cd /some/place/else
        git clone git://git.php.net/php-src.git
        cd php-src
        pwd
        cd /back/to/php_version_solution

* Edit `lib/phpvs/phpvs`.  Put the output of `pwd`, above, into the value
of `PHPVS_SRC_PATH`.  Adjust other values in the "USER CONFIGURATION"
section if needed.

* Edit the configure lines in the "USER CONFIGURATION" section of `bin/phpcm`.

* Edit the PECL packages in the "USER CONFIGURATION" section of `bin/phpi`.

* Edit the settings in `lib/phpvs/main.php.ini` (in particular the
`include_path`, `date.timezone`, and `error_log` values).  Do not add
`extension` enabling lines to that file.  Extension lines for PECL packages
are automatically placed in a version specific `extensions.php.ini` file
by `phpi`.

* If using xdebug, edit the settings in `lib/phpvs/xdebug.php.ini`.
`xdebug.trace_output_dir`, `xdebug.profiler_output_dir`, and
`xdebug.idekey` are the most important.

* Store your settings.

        git commit -am 'My initial customizations.'

* Adjust the `prefix` in `install.sh` if `/usr/local` is not acceptable.

* Install the files and adjust permissions.  Sets phpcm to be executable
by regular users, not root, to avoid permission conflicts in the checkout.

        ./install.sh

* Put the following in your ~/.bashrc.  The example, below, makes PHP 5.6
the default version.  Adjust the paths and version as needed.

        source /usr/local/lib/phpvs/phpvs
        phpvs 56

* Load the variables and functions by running this in each open terminal.
Don't worry about the error saying "php does not exist or is not
executable," that will be fixed upon installing the desired version of PHP.

        source ~/.bashrc

* Compile and install PHP 5.6.  Finish by making it the active version
of PHP for the current terminal session.

    Please be aware that `phpi` updates the version of PHP used by lighttpd
and/or Apache httpd depending on your configuration.  The most recently
installed version of PHP is the one used by the web server.

        cdsrc
        git checkout PHP-5.6
        git pull
        phpcm
        sudo phpi
        phpvs 56

* Install the centralized PEAR repository if one doesn't exist.

        wget http://pear.php.net/go-pear.phar
        export PHP_PEAR_PHP_BIN=/usr/local/bin/php
        sudo echo "#PEAR_Config 0.9" > /root/.pearrc
        sudo echo "a:0:{}" >> /root/.pearrc
        sudo chmod 400 /root/.pearrc
        sudo -E php go-pear.phar

    When asked to adjust the configuration:

    * `1 Installation base ($prefix)` set it to `/usr/local`
    * `5 PHP code directory ($php_dir)` set it to `/usr/local/share/pear`
    * `8 User-modifiable configuration files directory` set it to `/usr/local/cfg`
    * `11 Name of configuration file` set it to `/usr/local/etc/pear.conf`

    Once the install is done, adjust some other settings.

        sudo pear config-set auto_discover 1 system
        sudo pear config-set ext_dir "" system
        sudo pear config-set php_bin "/usr/local/bin/php" system
        sudo pear config-set sig_keydir "" system

    Disable the centralized pecl install to avoid conflicts with the
    pecl installed for each version of PHP.

        sudo chmod 644 /usr/local/bin/pecl

* Install the current and "old" PHPUnits.  The current one will be used
for PHP >= 5.6.  The old one will be used for PHP <= 5.5.

        wget -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
        chmod 755 /usr/local/bin/phpunit

        wget -O /usr/local/bin/phpunit-old https://phar.phpunit.de/phpunit-old.phar
        chmod 755 /usr/local/bin/phpunit-old
