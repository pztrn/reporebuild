# Reporebuild

**Reporebuild** is an Shell script, made to be a tool for running local (or not so local) repository with pre-built AUR packages.

## Installation

Just issue this in approriate directory:

    $ git clone https://forge.pztrn.name/pztrn/reporebuild.git

and you're set.

There is no additional dependencies, except of wget (for now) and bash. I'm trying to make this script very sleek and clean.

## Configuration

After first launch reporebuild will create a default configuration file with bad values for you. You should edit `~/.config/reporebuild.conf` by hand and fix them, otherwise I cannot guarantee good work.

## Packages list

List of packages, that will be rebuilt while issuing `reporebuild build all` are placed in `~/.config/reporebuild.list`. Every package should be placed on separate line. E.g.:

    gajim-hg
    psi-plus-git
    ...

## Licensing

For everyday usage **reporebuild** licensed under Beerware license (read BEERWARE for more information). If you making something on top of it - **reporebuild** licensed under Terms and Conditions of GNU General Public License version 2 or higher.
