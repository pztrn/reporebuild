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

# This library responsible for logging actions.

# Some things definitions.
# Log string itself
STRING=""

# Debug levels.
declare -A LEVELS
LEVELS["0"]=""
LEVELS["1"]="\033[1;36m[DEBUG]\033[0m "
LEVELS["2"]="\033[1;31m[HARDDEBUG]\033[0m "

# Message types
declare -A TYPES
TYPES["NORMAL"]="\033[1;32m===>\033[0m "
TYPES["WARN"]="\033[1;33m===> WARNING:\033[0m "
TYPES["ERROR"]="\033[1;31m===> ERROR:\033[0m "

# Is that log line is a question?
QUESTION=0

function log() {
    local LEVEL=$1
    shift
    local TYPE=$1
    shift
    local TEXT=$@

    # Make sure that STRING is empty.
    STRING=""

    get_level_format "${LEVEL}"

    # Show arrows only if this isn't a debug message.
    if [[ ${LEVEL} -eq 0 ]]; then
        get_type_format "${TYPE}"
    fi

    STRING+=${TEXT}

    if [[ ${DEBUG} -ge ${LEVEL} ]] && [[ ${LEVEL} -le ${DEBUG} ]]; then
        if [[ $QUESTION -eq 1 ]]; then
            echo -ne ${STRING}
            QUESTION=0
        else
            echo -e ${STRING}
        fi
    fi
}

# Ask user for bool qestions (Yes/No).
function read_bool_answer() {
    local question=$1
    QUESTION=1
    log 0 "WARN" " ${question} "
    QUESTIOIN=0
    read answer
    if [ $answer = "y" -o $answer = "Y" -o $answer = "" ]; then
        return 1
    else
        return 0
    fi
}

function get_level_format() {
    STRING+="${LEVELS[$1]}"
}

function get_type_format() {
    STRING+="${TYPES[$1]}"
}
