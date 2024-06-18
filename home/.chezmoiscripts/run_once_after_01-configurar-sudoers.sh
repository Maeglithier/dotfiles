#!/bin/bash

if [[ ! -f "/etc/sudoers.d/disable_admin_file_in_home" ]]; then
  printf "# Disable ~/.sudo_as_admin_successful file\\nDefaults \!admin_flag\\nl" | sudo tee /etc/sudoers.d/disable_admin_file_in_home >/dev/null
fi

rm -rf ~/.sudo_as_admin_successful
