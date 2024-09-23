$AXFUN
import axeron.prop
w="[!]" #warn
i="[?]" #info
s="[\$]" #success
axeron="com.fhrz.axeron"
host="fahrez256.github.io"
host_path="/Laxeron/Core_2404.txt"
id_path="/Laxeron/Id_2404.txt"
log_path="/sdcard/Android/data/${axeron}/files"
log_file="${log_path}/log.txt"
this_core=$(dumpsys package ${axeron} | grep "signatures" | cut -d '[' -f 2 | cut -d ']' -f 1)
vCode=4100
vName="V4.2 ShellStorm"
vAxeron=10240121
androidId=$(settings get secure android_id)

#echo "fcore $@"
if [ -n "$1" ] && [ "$1" == "-p" ];then
        if [ -n "$2" ]; then
            axprop $path_axeronprop runPackage -s "$2"
            runPackage="$2"
            shift 2
        else
            shift
        fi
fi

axeron_core="Optione {
  key:id=\"$id\";
  key:name=\"$name\";
  key:version=\"$version\";
  key:versionCode=${versionCode};
  key:author=\"$author\";
  key:description=\"$description\";
  key:runPackage=\"$runPackage\";
  key:install=\"$install\";
  key:remove=\"$remove\";
}
"

core_info="Optione {
  key:versionCode=${vCode};
  key:versionAxeron=${vAxeron};
  key:androidId=\"$androidId\";
  key:host=\"$host\";
  key:hostPath=\"$host_path\";
  key:idPath=\"$id_path\";
  key:versionName=\"$vName\";
  key:axeronSupport=${vAxeron};
}
"

join_channel() {
  sleep 1
  am start -a android.intent.action.VIEW -d "https://t.me/fahrezone_ch" > /dev/null 2>&1
}

c_exit() {
  rm -f "response" > /dev/null 2>&1
  exit 0
}

optimize_app() {
  for package in $(pkglist); do
    if ! whitelist | grep -q "$package" >/dev/null 2>&1 && [ ! "$runPackage" == "$package" ]; then
      cache_path="/sdcard/Android/data/${package}/cache"
      #[ -e "$cache_path" ] && rm -rf "$cache_path" > /dev/null 2>&1
      am stop-app "$package" > /dev/null 2>&1
    fi
  done
}

ram_cleaner() {
  for app in $(cmd package list packages -3 | cut -f 2 -d ":"); do
if [[ ! "$app" == "com.fhrz.axeron" ]]; then
cmd activity force-stop "$app"
cmd activity kill "$app"
fi
done
}

if [ "$AXERON" ] && ! echo "$CORE" | grep -q "$this_core"; then
  echo "└$w You must use the original version of Axeron"
  join_channel
  c_exit
fi

if [ -z "$runPackage" ]; then
  echo "└$w PackageName is empty" && c_exit
elif ! echo "$(pkglist)" | grep -qw "$runPackage"; then
  echo "└[ $runPackage ] is not detected or installed" && c_exit
fi

if ! command -v am > /dev/null || ! command -v pm > /dev/null; then
  echo "└$w ActivityManager & PackageManager not Permitted" && c_exit
fi

if echo "$(pkglist)" | grep -qw "$axeron"; then
  echo "└$s LAxeron is detected [Fast Connect+]"
  toast "GSpeed" "Fast Connect LAxeron 2.0" 3000
else
  echo "├$w LAxeron not Installed"
  echo "└$i Please download LAxeron app from FahrezONE officially"
  join_channel
  c_exit
fi

mkdir -p "$log_path"
current_time=$(date +%s%3N)
last_time=$(cat "$log_file" 2>/dev/null)
time_diff=$((current_time - last_time))

if [ "$time_diff" -ge 2700000 ] || [ ! -e "$log_file" ]; then
  optimize_app
  ram_cleaner
  echo -n "$current_time" > "$log_file"
fi

am start -a android.intent.action.VIEW -n "com.fhrz.axeron/.Process" --es AXERON "$axeron_core" --es CORE "$core_info" > /dev/null 2>&1
c_exit
