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

# This library responsible for all package building actions.

# Actual package building.
function build_package() {
    local PKGNAME=$1
    local PKGBUILD_PATH=$2

    if [ ! -d $PKGBUILD_PATH/$PKGNAME ]; then
        log 0 "ERROR" "PKGBUILD for '${PKGNAME}' not found."
        exit 20
    fi

    cd $PKGBUILD_PATH/$PKGNAME
    log 1 "NORMAL" "Executing makepkg..."
    makepkg -f &> $LOGPATH/reporebuild-$PKGNAME.log
    if [ $? != 0 ]; then
        log 0 "ERROR" "Build error. Last 6 lines from log:"
        echo
        cat $LOGPATH/reporebuild-$PKGNAME.log | tail -n 6
        echo
        log 1 "NORMAL" "Adding '{$PKGNAME}' to list of failed packages..."
        echo "  " $PKGNAME >> /tmp/reporebuild/failed.list
    else
        log 0 "NORMAL" "Rebuild complete. Moving package \033[1;31m$PKGNAME\033[0m to repository dir and update repo database... "
        log 1 "NORMAL" "Updating repository..."
        log 2 "NORMAL" "Removing old package..."
        rm $REPOPATH/$PKGNAME*.pkg.tar.* &> /dev/null
        log 2 "NORMAL" "Moving new package into repository..."
        mv $PKGBUILD_PATH/$PKGNAME/$PKGNAME*.pkg.tar.* $REPOPATH &> /dev/null
        log 2 "NORMAL" "Updating repository metadata..."
        cd $REPOPATH && rm $REPONAME.db.tar.gz &> /dev/null
        repo-add $REPONAME.db.tar.gz *.pkg.tar.gz *.pkg.tar.xz &> /dev/null
    fi
}

# Do some preliminary actions (like PKGBUILD fetching), and launch
# build_package().
function build_from_aur() {
    local PKGNAME=$1

    if [ ! -d $PKGBUILDSPATH/$PKGNAME ]; then
        log 1 "WARN" "Directory for '${PKGNAME}' not found, creating"
        mkdir -p $PKGBUILDSPATH/$PKGNAME
    fi

    log 0 "NORMAL" "(Re)Build package: \033[1;31m$PKGNAME\033[0m"
    read_bool_answer "PKGBUILD for package \033[1;31m$PKGNAME\033[0m will be saved in $PKGBUILDSPATH/$PKGNAME directory. Want to proceed [Y/N]?"

    if [ $? -eq 1 ]; then
        fetch_package_from_aur $PKGNAME $PKGBUILDSPATH

        log 0 "NORMAL" "Building package \033[1;31m$PKGNAME\033[0m..."
        build_package $PKGNAME $PKGBUILDSPATH
    else
        fetch_package_from_aur $PKGNAME /tmp/reporebuild/
        tar -xf $PKGNAME.tar.gz -C /tmp/reporebuild/
        cd /tmp/reporebuild/$PKGNAME
        log 0 "NORMAL" "Fetching Complete. Building package..."
        build_package $PKGNAME /tmp/reporebuild
    fi

}

# Some endless loop for PKGBUILD editing. Kinda like yaourt one.
function edit_pkgbuild(){
    while true; do
        read_bool_answer "NORMAL" "Fetching Complete. Would you like to edit PKGBUILD (will use $EDITOR)? [Y/N] "
        if [ $? -eq 1 ]; then
            if [ "$EDITOR" == "" ]; then
                echo -n -e "\033[1;31m===>\033[0m Editor not specified (e.g. exported from \033[1;32m/etc/profile\033[0m). Enter your favorite editor: "
                read editorans
                export EDITOR="$editorans"
            fi
            $EDITOR $PKGBUILDSPATH/$PKGNAME/PKGBUILD
        elif [ $? -eq 0 ]; then
            break
        fi
    done
}
