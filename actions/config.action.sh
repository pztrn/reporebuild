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

# Configuration actions application.

# Parameters parser.
function config_main() {
    show_config
}

# This method shows reporebuild configuration.
function show_config() {
    echo -e "\033[1;32mPKGBUILDs located at:\033[1;33m" $PKGBUILDSPATH
    echo -e "\033[1;32mRepository path:\033[1;36m" $REPOPATH
    echo -e "\033[1;32mRepository name:\033[1;37m" $REPONAME
    echo -e "\033[1;32mBuild log located at:\033[1;31m" $LOGPATH
    echo
    echo -e "\033[0mIf this information incorrect - fix it in ~/.config/reporebuild.conf"
    exit 0
}
