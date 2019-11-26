#!/bin/bash
set -x
set -e
>/root/make-kamikaze.log
exec >  >(tee -ia /root/make-kamikaze.log)
exec 2> >(tee -ia /root/make-kamikaze.log >&2)

# Get the versioning information from the entries in version.d/
export VERSIONING=`pwd`/Packages/version.d
for f in `ls ${VERSIONING}/*`
  do
    source $f
  done

echo "**Making ${VERSION}**"
export LC_ALL=C
export PATH=`pwd`/Packages:$PATH

install_redeem
install_octoprint_redeem
install_octoprint_toggle
install_toggle
# install_cura
# install_slic3r
install_u-boot
make_general_adjustments
install_usbreset
install_smbd
install_dummy_logging
install_videostreamer
install_ffmpeg
rebrand_ssh
perform_cleanup
prepare_flasher

echo "Now reboot!"
