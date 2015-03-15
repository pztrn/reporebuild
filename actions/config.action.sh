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
