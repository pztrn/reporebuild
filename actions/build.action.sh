#Copyright (C) 2010-2015, Stanislav N. aka pztrn
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


# Package building appllication.

# This function do parameters parsing.
build_main() {
    local TYPE=$1

    log 2 "NORMAL" "Passed parameters: $@"

    if [ "${TYPE}" == "all" ]; then
        log 0 "NORMAL" "Rebuilding all packages"
        all
    elif [ "${TYPE}" == "local" ]; then
        log 0 "NORMAL" "Executing local packages building for:"
        shift
        PACKAGES=$@
        log 0 "NORMAL" "${PACKAGES}"
        localbuildpkg ${PACKAGES}
    else
        log 0 "NORMAL" "Building packages from AUR:"
        log 0 "NORMAL" $@
        buildfromaur $@
    fi
}

# This function checks for packages list existing.
# This packages list should be placed in $HOME/.config/reporebuild.list.
function check_packages_list_file() {
    if [ ! -f "~/.config/reporebuild.list" ]; then
        log 0 "ERROR" "ERROR: packages list not found!"
        log 0 "ERROR" "Either create one by hand, or use 'build pkgnames'!"
        exit 10
    else
        log 1 "NORMAL" "File with list of packages to rebuild exist."
    fi
}

# Starting point to build all packages.
# Essentially, this method just prints out a message and starts build()
# function.
all () {
    log 0 "NORMAL" "Rebuild all packages.\033[0m Output redirected to $LOGPATH/reporebuild-PKGNAME.log"
    buildpkg
}

# Finish point. Printing list of failed packages (if they're present),
# or just saying, that "Job completed".
buildpkg_done () {
    if [ -f /tmp/reporebuild/failed.list ]; then
        echo -e "\033[1;31m===>\033[0m These packages are failed to built:"
        cat /tmp/reporebuild/failed.list
        exit
    else
        log 0 "NORMAL" "Job completed. Check $LOGPATH/reporebuild-PKGNAME.log for details."
        exit
    fi
    exit
}

# This method iterates over reporebuild.list file and feed packages
# to build_package() function from lib/builder.lib.sh.
buildpkg () {
    tmpdir
    check_packages_list_file

    for PKGNAME in $(cat ~/.config/reporebuild.list); do
        log 0 "NORMAL" "Rebuilding package: \033[1;31m$PKGNAME\033[0m"
        build_package $PKGNAME $PKGBUILDSPATH
    done

    buildpkg_done
}

# This method responsible for package building from AUR.
buildfromaur () {
    PACKAGES=$@
    for PKGNAME in ${PACKAGES}; do
        build_from_aur $PKGNAME
    done

    buildpkg_done
}

# This method responsible for package building from local
# PKGBUILD storage.
localbuildpkg () {
    PACKAGES=$@
    for PKGNAME in ${PACKAGES}; do
        log 0 "NORMAL" "Rebuild package: \033[1;31m$PKGNAME\033[0m"
        build_package $PKGNAME $PKGBUILDSPATH
    done

    buildpkg_done
}
