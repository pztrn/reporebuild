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
    cd $DESTINATION/$PKGNAME && wget https://aur.archlinux.org/packages/$SHORT_PKGNAME/$PKGNAME/$PKGNAME.tar.gz &>/dev/null
    if [ $? -eq 8 ]; then
        log 0 "ERROR" "Invalid package name!"
        rm -rf $DESTINATION/$PKGNAME &>/dev/null
        exit 8
    fi
    if [ $? -eq 7 ]; then
        log 0 "ERROR" "Protocol error."
        echo "  " $PKGNAME >> /tmp/reporebuild/failed.list
        rm -rf $DESTINATION/$PKGNAME &>/dev/null
        exit 7
    fi
    if [ $? -eq 5 ]; then
        log 0 "ERROR" "SSL verification failed. Cannot download PKGBUILD."
        echo "  " $PKGNAME >> /tmp/reporebuild/failed.list
        rm -rf $DESTINATION/$PKGNAME &>/dev/null
        exit 5
    fi
    if [ $? -eq 4 ]; then
        log 0 "ERROR" "Network failure. No connection established?"
        echo "  " $PKGNAME >> /tmp/reporebuild/failed.list
        rm -rf $DESTINATION/$PKGNAME &>/dev/null
        exit 4
    fi
    if [ $? -eq 3 ]; then
        log 0 "ERROR" "I/O Error. Out of space or inodes?"
        rm -rf $DESTINATION/$PKGNAME &>/dev/null
        echo "  " $PKGNAME >> /tmp/reporebuild/failed.list
        exit 3
    fi
    if [ $? -eq 1 ]; then
        log 0 "ERROR" "Really unknown error. Wget returned 1."
        echo "  " $PKGNAME >> /tmp/reporebuild/failed.list
        rm -rf $DESTINATION/$PKGNAME &>/dev/null
        exit 1
    fi
    tar -xf $PKGNAME.tar.gz -C $DESTINATION
    echo -e "\033[1;32mSUCCESS\033[0m"

    if [ -f /tmp/reporebuild/failed.list ]; then
        log 0 "ERROR" "These packages are failed to be fetched:"
        cat /tmp/reporebuild/failed.list
        exit
    fi
}
