$AXFUN
import axeron.prop
local defcore="https://fahrez256.github.io/Laxeron/shell/core.sh"
local vip="https://lrzozz256.github.io/GSpeed/vip/install.sh"
local id="$(getprop ro.serialno)"
local check_id="$(storm https://lrzozz256.github.io/GSpeed/id_vip.txt)"
local trim_id="${id:0:8}"
local full_version=$(echo "$check_id" | grep -q "$trim_id" && echo true || echo false)

if [ $full_version = true ]; then
  storm -x "$vip" -fn "vip" "$@"
  toast "GSpeed" "You Are ViP User!" 5000
  exit 0
fi

echo "$name | Free"
echo "Get Turbo Booster? buy \$1"
storm -x "$defcore" -fn "defcore" "$@"