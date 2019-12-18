#!/usr/bin/env bash
set -euf -o pipefail

# get volume and status from amixer with some beautiful regex and then strip [, ] as well as 'on' with even more beautiful regex before trimming all trailing whitespaces
function getVol() {
  amixer -D pulse sget Master | rg -o '\[[0-9]+%\] \[(on|off)\]' | head -n1 | sed 's/\(\[\|\]\|on\)//g' | sed 's/[[:space:]]*$//'
}

case "${1:-}" in
"volume")
  volFrom=$(getVol)

  case "${2:-}" in
  "up")
    amixer -q -D pulse sset Master 5%+
    ;;
  "down")
    amixer -q -D pulse sset Master 5%-
    ;;
  "mute")
    amixer -q -D pulse sset Master toggle
    ;;
  "*")
    echo "usage: s audio volume <up|down|mute>"
    ;;
  esac

  volString="${volFrom} → $(getVol)"
  echo "${volString}"
  notify-send -u low -t 500 -a "s audio" "Volume" "${volString}"
  ;;
"spotify" | "player")
  player="spotify"
  case "${2:-}" in
  "play" | "pause")
    playerctl -p ${player} play-pause &
    ;;
  "next")
    playerctl -p ${player} next &
    ;;
  "prev" | "previous")
    playerctl -p ${player} previous &
    ;;
  "stop")
    playerctl -p ${player} stop &
    ;;
  *)
    echo "usage: s audio spotify <play|pause|next|prev/previous|stop>"
    exit 1
    ;;
  esac
  ;;
*)
  echo "usage: s audio <volume <up|down|mute>>"
  ;;
esac
