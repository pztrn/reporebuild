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

function check_packages_list_file() {
    if [ ! -f "~/.config/reporebuild.list" ]; then
        log 0 "ERROR" "ERROR: packages list not found!"
        log 0 "ERROR" "Either create one by hand, or use 'build pkgnames'!"
        exit 10
    else
        log 1 "NORMAL" "File with list of packages to rebuild exist."
    fi
}

all () {
    log 0 "NORMAL" "Rebuild all packages.\033[0m Output redirected to $LOGPATH/reporebuild-PKGNAME.log"
    buildpkg
}

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

buildpkg () {
    tmpdir
    check_packages_list_file

    for PKGNAME in $(cat ~/.config/reporebuild.list); do
        log 0 "NORMAL" "Rebuilding package: \033[1;31m$PKGNAME\033[0m"
        build_package $PKGNAME $PKGBUILDSPATH
        PKGNAME=PKGNAME+1
    done

    buildpkg_done
}

buildfromaur () {
    PACKAGES=$@
    for PKGNAME in ${PACKAGES}; do
        build_from_aur $PKGNAME
    done

    buildpkg_done
}

localbuildpkg () {
    PACKAGES=$@
    for PKGNAME in ${PACKAGES}; do
        log 0 "NORMAL" "Rebuild package: \033[1;31m$PKGNAME\033[0m"
        build_package $PKGNAME $PKGBUILDSPATH
    done

    buildpkg_done
}