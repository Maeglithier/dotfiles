if [ ! -d "${XDG_SOURCE_HOME}/asdf" ]; then
  echo "Instalando asdf..."
  git clone https://github.com/asdf-vm/asdf.git ${XDG_SOURCE_HOME}/asdf > /dev/null 2>&1
fi