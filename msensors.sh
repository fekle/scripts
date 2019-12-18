#!/usr/bin/env bash
set -euf

function get_hwmon() {
  echo $(find "${@}" -maxdepth 1 -type d -regex ".*/hwmon[0-9]+")
}

function tempscale() {
  echo "scale=0;$(cat ${1})/1000" | bc
}

coretemp_path=$(get_hwmon /sys/devices/platform/coretemp.0/hwmon)
motherboard_path=$(get_hwmon /sys/devices/platform/nct6775.656/hwmon)

cpu=$(tempscale ${coretemp_path}/temp1_input)
cpu1=$(tempscale ${coretemp_path}/temp2_input)
cpu2=$(tempscale ${coretemp_path}/temp3_input)
cpu3=$(tempscale ${coretemp_path}/temp4_input)
cpu4=$(tempscale ${coretemp_path}/temp5_input)
cpu5=$(tempscale ${coretemp_path}/temp6_input)
cpu6=$(tempscale ${coretemp_path}/temp7_input)

gpu=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader) || gpu="error"
gpufan=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader) || gpufan="error"

systemp=$(tempscale ${motherboard_path}/temp1_input)
syscputemp=$(tempscale ${motherboard_path}/temp2_input)
peci=$(tempscale ${motherboard_path}/temp7_input)

fan2=$(cat ${motherboard_path}/fan2_input)
fan4=$(cat ${motherboard_path}/fan4_input)
fan5=$(cat ${motherboard_path}/fan5_input)

# SYSTIN - motherboard temp
# CPUTIN - motherboard cpu temp

TEMP_UNIT="°C"

echo "
 === Temperatures ===

 Motherboard 1    ${systemp} ${TEMP_UNIT}
 Motherboard 2    ${syscputemp} ${TEMP_UNIT}
 PECI             ${peci} ${TEMP_UNIT}

 CPU Package      ${cpu} ${TEMP_UNIT}
 CPU Core 1       ${cpu1} ${TEMP_UNIT}
 CPU Core 2       ${cpu2} ${TEMP_UNIT}
 CPU Core 3       ${cpu3} ${TEMP_UNIT}
 CPU Core 4       ${cpu4} ${TEMP_UNIT}
 CPU Core 5       ${cpu5} ${TEMP_UNIT}
 CPU Core 6       ${cpu6} ${TEMP_UNIT}

 GPU              ${gpu} ${TEMP_UNIT}

 === Fan Speeds ===

 CPU Fans         ${fan2} RPM
 Top Fans         ${fan4} RPM
 Back Fan         ${fan5} RPM
 GPU              ${gpufan}
"
