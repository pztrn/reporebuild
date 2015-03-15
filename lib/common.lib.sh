# This library responsible for common actions.

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
