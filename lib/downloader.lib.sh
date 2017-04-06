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

# Downloader library.

# This method downloads PKGBUILD and neccessary file from AUR, within
# one tarball.
function fetch_package_from_aur() {
    local PKGNAME=$1
    local DESTINATION=$2
    SHORT_PKGNAME=$(echo ${PKGNAME} | cut -c 1-2)
    log 1 "NORMAL" "Saving PKGBUILD to '${DESTINATION}/${PKGNAME}'..."
    QUESTION=1
    log 0 "NORMAL" "Fetching PKGBUILD for: \033[1;31m$PKGNAME\033[0m... "
    mkdir -p $DESTINATION/$PKGNAME
    cd $DESTINATION/$PKGNAME
    ${GIT} clone https://aur.archlinux.org/ttf-play.git .
    if [ $? -ne 0 ]; then
        log 0 "ERROR" "Error occured while fetching package."
        exit 2
    fi
}
