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

# This library responsible for common actions.

# This function check passed parameters length.
# If it is zero - return 1, otherwise 0.
function check_params_length() {
    params=$@
    if [ ${#params[@]} -eq 0 ]; then
        return 1
    else
        return 0
    fi
}

# This function check prerequisites.
function check_prereq()
{
    log 2 "NORMAL" "Searching for wget..."
    WGET=$(whereis -b wget)
    WGET=$(echo ${WGET} | cut -d ":" -f 2)
    log 2 "NORMAL" "wget binary path: ${WGET}"
    if [ ${#WGET[@]} -eq 0 ]; then
        log 0 "ERROR" "WGET isn't found! ${WGET}"
    fi
}

# Temporary directory check.
# If temporary directory does not exist - it will create one.
function tmpdir() {
    if [ ! -d /tmp/reporebuild ]; then
        mkdir -p /tmp/reporebuild &> /dev/null
    else
        rm /tmp/reporebuild/{failed.list,reporebuild.tmp} &> /dev/null
    fi
    if [ ! -d $LOGPATH ]; then
        mkdir -p $LOGPATH
    fi
    if [ ! -d $REPOPATH ]; then
        read_bool_answer "Repository path does not exist. Create? "
        if [ $? -eq 1 ]; then
            mkdir -p $REPOPATH
        else
            log 0 "ERROR" "Repository path wasn't created."
            exit 30
        fi
    fi
}
