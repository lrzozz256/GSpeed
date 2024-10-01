$AXFUN
import axeron.prop
local modcore="https://lrzozz256.github.io/GSpeed/vip/core.sh"
local id="$(getprop ro.serialno)"
local check_id="$(storm https://lrzozz256.github.io/GSpeed/id_vip.txt)"
local trim_id="${id:0:8}"

case $1 in
  --info | -i )
    echo "$name | Information"
    echo "ID: $trim_id"
    echo "Plan: VIP"
    echo "Version: $version($versionCode)"
    echo "Whoami: $(whoami) | $(id -u)"
    echo "SELinux: $(getenforce)"
    exit 0
    ;;
esac

echo "$name | VIP"
sleep 1
echo "Thanks For Buy, enjoy!"
sleep 1
echo "[ ➤ ] Target Package: $runPackage"
sleep 2
storm -x "$modcore" -fn "modcore" "$@"
