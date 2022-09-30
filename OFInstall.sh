#!/bin/bash
printf "\e[1;35m\nOpen Fortress installer and updater\e[0m\n"

TMPOFDIR=$(mktemp -dt OFtmp-XXXXXXXXXXXXXXXX)
printf "\n\e[1;33mWorking...\e[0m"
{
curl -L -o "${TMPOFDIR}/murse0.3.2.tar.gz" https://git.sr.ht/~welt/murse/refs/download/v0.3.2/murse-v0.3.2-linux-386.tar.gz
tar xvzf "${TMPOFDIR}/murse0.3.2.tar.gz" -C "${TMPOFDIR}"
chmod +x "${TMPOFDIR}/murse"
}&> /dev/null

if [ ~ == "/root" ]; then
    ACTUAL_HOME="/home/${SUDO_USER}"
else
    ACTUAL_HOME=~
fi
if [ ! -d "${ACTUAL_HOME}/.steam/steam/steamapps/sourcemods/open_fortress" ]
then
    mkdir -p "${ACTUAL_HOME}/.steam/steam/steamapps/sourcemods/open_fortress"
fi
INSTALL_LOCATION="${ACTUAL_HOME}/.steam/steam/steamapps/sourcemods/open_fortress"
printf "\n\e[1;32mInstalling to "${INSTALL_LOCATION}"\e[0m\n"
printf "\e[1;35mThis may take a while, be patient. Any errors are likely the servers fault, just run this script again.\n\e[0m"
printf "\e[1;35mIf there are issues in game(missing textures, models, etc) run this script again.\n\e[0;32m"

"${TMPOFDIR}/murse" upgrade "$INSTALL_LOCATION"
printf "\n\e[1;33mVerifying installation\n\e[0m\e[0;33m"

"${TMPOFDIR}/murse" verify -r "$INSTALL_LOCATION"
printf "\n\e[1;35mPrompting steam to install TF2 and the 2013 Multiplayer Source SDK, they are required to play Open Fortress.\e[0m"

{
xdg-open steam://install/243750
xdg-open steam://install/440
}&> /dev/null

rm -r "${TMPOFDIR}"
printf "\n\n\e[1;32mDone! \e[0m\n"