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

# Help application. Does nothing more, than showing help.

function help_main() {
    help
}

function help () {
    clear
    echo "=================================================================================="
    echo -e "\033[1;32mLocal repository rebuild script\033[0m version 1.2"
    echo -e "\033[1;33mUsage:\033[0m"
    echo "reporebuild [OPTION] pkgname1 pkgname2 ... pkgnameN"
    echo
    echo "Options:"
    echo "    build all              rebuild all packages specified in ~/.config/reporebuild.list"
    echo ""
    echo "    build pkgname          build specified package from AUR (PKGBUILD will be saved"
    echo "                           in PKGBUILDS directory for later usage with -l)"
    echo ""
    echo "    fetch pkgname          fetch PKGBUILD from AUR without building"
    echo ""
    echo "    build local pkgname    rebuild only specific package from local PKGBUILD"
    echo ""
    echo "    config show            shows current reporebuild configuration"
    echo
    echo "You must create ~/.config/reporebuild.conf! See created one for example."
    echo "PKGBUILDs must be placed in <pkgname> folder (for example, for PSI-PLUS package:"
    echo "psi-plus/PKGBUILD)"
    echo
    echo "List of packages in your local repository must be placed in ~/.config/reporebuild.list"
    echo "Example contents of ~/.config/reporebuild.list:"
    echo
    echo "packagename1"
    echo "packagename2"
    echo "..."
    echo "packagenameN"
    echo
    echo "=================================================================================="
}
