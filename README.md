rdrshell
===========================================================

An extensible organization of my bash dotfiles.

authors:

-   Ryan Reece <ryan.reece@cern.ch>

created: March 3, 2015


Installation
-------------------------------------------------------------

First, clone this package into your home directory as ".rdrshell":

    git clone git@github.com:rreece/rdrshell.git .rdrshell

Then run the install script, that simply copies the dotfiles into your $HOME:

    cd .rdrshell
    source install.sh

Then you can add whatever plugins or personal scripts you want to the .rdrshell/init/
directory and they will be sourced automatically in your next bash shell.
For example:

    cp plugins/hep init/


License
----------------------------------

-   Copyright 2015 Ryan Reece
-   License: GPL <http://www.gnu.org/licenses/gpl.html>


