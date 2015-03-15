# This library responsible for any actions with configuration file.

# Configuration check
# If file does not exist - it will create it.
function configcheck() {
    if [ ! -f ~/.config/reporebuild.conf ]; then
        echo "PKGBUILDSPATH=/data/PKGBUILDS" >> ~/.config/reporebuild.conf
        echo "REPOPATH=/data/WWW/pztrn.ru/repo/i686" >> ~/.config/reporebuild.conf
        echo "REPONAME=pozitpoh" >> ~/.config/reporebuild.conf
        echo "LOGPATH=~/reporebuildlogs" >> ~/.config/reporebuild.conf
        echo "LOG_LINES_COUNT_ON_EXIT=10" >> ~/.config/reporebuild.conf
        echo "# Please, remove next line when configuration will be ok ;)
        echo "REMOVETHISLINE=1" >> ~/.config/reporebuild.conf"
    fi
    if [ "$REMOVETHISLINE" == "1" ]; then
        echo -e "\033[1;31m===> ERROR:\033[0m Please, verify your config located at \033[1;32m~/.config/reporebuild.conf\033[0m"
        exit 255
    fi
}
