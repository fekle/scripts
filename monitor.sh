#!/usr/bin/bash
set -euf -o pipefail

s hasdisplay || exit 0

# check arg count
if [ ${#} -eq 0 ]; then
  s help ${0}
  exit 1
fi

# switch trough arg and set output configs
if s device pc; then
  case "${1}" in
  single)
    nvidia-settings --assign CurrentMetaMode="DP-2: 3840x2160_120 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    ;;
  dual | default)
    nvidia-settings --assign CurrentMetaMode="DP-2: 3840x2160_120 +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: 3840x2160_60 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}"
    ;;
  triple)
    nvidia-settings --assign CurrentMetaMode="DP-2: 3840x2160_120 +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-0: 3840x2160_60 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}"
    ;;
  *)
    exit 1
    ;;
  esac
elif s device felix-xps; then
  # everything off by default
  eDP1="--off"
  DP1="--off"
  DP2="--off"
  HDMI1="--off"
  HDMI2="--off"
  VIRTUAL1="--off"

  case "${1}" in
  internal | default)

    eDP1="--auto --primary --mode 3840x2160 --pos 0x0 --scale 1x1"
    ;;
  external)

    HDMI1="--auto --primary --mode 1920x1080 --pos 0x0 --scale 1x1"
    ;;
  work)
    HDMI1="--auto --mode 3840x2160 --rate 60 --pos 0x0 --scale 1x1"
    DP2="--auto --primary --mode 3840x2160 --rate 60 --pos 3840x0 --scale 1x1"
    eDP1="--auto --mode 3840x2160 --rate 60 --pos 7680x0 --scale 0.5x0.5"
    ;;
  workold)
    eDP1="--auto --primary --mode 3840x2160 --rate 60 --pos 0x0 --scale 1x1"
    HDMI1="--auto --mode 1920x1080 --rate 60 --pos 3840x0 --scale 2x2"
    ;;

  kitchen)

    HDMI1="--auto --mode 1920x1080 --pos 3840x0 --scale 2x2"
    eDP1="--auto --mode 3840x2160 --pos 0x0 --scale 1x1"
    ;;
  kitchen-mirror)

    HDMI1="--auto --mode 1920x1080 --pos 0x0 --scale 2x2"
    eDP1="--auto --mode 3840x2160 --pos 0x0 --scale 1x1"
    ;;
  TV)

    HDMI1='--auto --rate 60 --primary --mode 3840x2160 --pos 0x0 --scale 1x1'
    #      eDP1='--auto --rate 60 --mode 3840x2160 --pos 0x0 --scale 1x1'
    ;;
  TV2)

    HDMI1='--auto --rate 60 --primary --mode 1920x1080 --pos 0x0 --panning 1920x1080 --scale 1x1'
    ;;
  TV3)

    HDMI1='--auto --rate 30 --primary --mode 1920x1080 --pos 0x0 --scale 2x2 --panning 3840x2160'
    ;;
  TV4)

    HDMI1='--auto --rate 25 --primary --mode 1920x1080 --pos 0x0 --scale 2x2 --panning 3840x2160'
    ;;
  TV5)

    HDMI1='--auto --rate 50 --primary --mode 1920x1080 --pos 0x0 --scale 2x2 --panning 3840x2160'
    ;;
  TV6)

    HDMI1='--auto --rate 50 --primary --mode 1920x1080 --pos 0x0 --scale 2x2 --panning 3840x2160'
    ;;
  *)
    ${0}
    exit 1
    ;;
  esac

  # enable Nvidia PRIME
  xrandr --setprovideroutputsource modesetting NVIDIA-0

  # apply xrandr config
  xrandr --setprovideroutputsource modesetting NVIDIA-0 --auto \
    --output eDP-1-1 ${eDP1} \
    --output DP-1-1 ${DP1} \
    --output DP-1-2 ${DP2} \
    --output HDMI-1-1 ${HDMI1} \
    --output HDMI-1-2 ${HDMI2}

else
  exit 0
fi

# # wait for short
sleep .1

# set color profile
echo 'set color...'
#s color &>/dev/null || true

# set wallpaper
#feh --bg-scale ~/img/grey.png
#hsetroot -solid "#000000" || xsetroot -solid "#000000"

sleep .1
# set wallpaper
#echo 'restart i3...'
#i3-msg -- restart
