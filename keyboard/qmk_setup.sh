(
  cd ~/Development/qmk_firmware;
  git pull
  make git-submodule
)

# cp -R redox ~/Development/qmk_firmware/keyboards/redox/devinclark

cp -R kbd75 ~/Development/qmk_firmware/keyboards/kbdfans/kbd75/keymaps/devinclark
