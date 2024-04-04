#!/usr/bin/bash

if [[ ! -f "/etc/sudoers.d/disable_admin_file_in_home" ]]; then
    sudo sh -c 'echo "# Disable ~/.sudo_as_admin_successful file\nDefaults !admin_flag" > /etc/sudoers.d/disable_admin_file_in_home';
fi

rm -rf ~/.sudo_as_admin_successful;