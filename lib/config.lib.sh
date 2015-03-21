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

# This library responsible for any actions with configuration file.

# Configuration check
# If file does not exist - it will create it.
function configcheck() {
    if [ ! -f ~/.config/reporebuild.conf ]; then
        touch ~/.config/reporebuild.conf
        echo "PKGBUILDSPATH=/data/PKGBUILDS" >> ~/.config/reporebuild.conf
        echo "REPOPATH=/data/WWW/pztrn.ru/repo/i686" >> ~/.config/reporebuild.conf
        echo "REPONAME=pozitpoh" >> ~/.config/reporebuild.conf
        echo "LOGPATH=~/reporebuildlogs" >> ~/.config/reporebuild.conf
        echo "LOG_LINES_COUNT_ON_EXIT=10" >> ~/.config/reporebuild.conf
        echo "# Please, remove next line when configuration will be ok ;)" >> ~/.config/reporebuild.conf
        echo "REMOVETHISLINE=1" >> ~/.config/reporebuild.conf
    fi
    if [ "$REMOVETHISLINE" == "1" ]; then
        echo -e "\033[1;31m===> ERROR:\033[0m Please, verify your config located at \033[1;32m~/.config/reporebuild.conf\033[0m"
        exit 255
    fi

    source ~/.config/reporebuild.conf
}
