if [ ! -d "${XDG_SOURCE_HOME}/asdf" ]; then
  echo "Instalando asdf..."
  git clone https://github.com/asdf-vm/asdf.git ${ASDF_DIR} > /dev/null 2>&1
fi