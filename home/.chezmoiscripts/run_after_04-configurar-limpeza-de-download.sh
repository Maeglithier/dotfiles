#!/bin/bash

USER=$(whoami);
SCRIPT="/usr/local/bin/clear-downloads.sh"
SERVICE="/etc/systemd/system/clear-downloads.service"

if [ ! -f "$SERVICE" ]; then
  sudo bash -c "cat > $SERVICE" <<EOF
[Unit]
Description=Clear Downloads Folder on Boot

[Service]
Type=oneshot
ExecStart=$SCRIPT

[Install]
WantedBy=multi-user.target
EOF
fi

if [ ! -f "$SCRIPT" ]; then
  sudo bash -c "cat > $SCRIPT" <<EOF
#!/bin/bash
rm -rf /home/$USER/Arquivos/Downloads/Temp/*
EOF
  sudo chmod +x $SCRIPT
fi

sudo systemctl enable clear-downloads.service
sudo systemctl start clear-downloads.service