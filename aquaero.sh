#!/usr/bin/env bash
set -euf -o pipefail

data=$(curl -Ls http://localhost:9500/status)

printf "### aquaero fans ###\n"
printf "%-16s: %-16s\n" "pumpSpeed" "$(jq '.fans[0].speed' <<<"${data}") rpm"
printf "%-16s: %-16s\n" "bottomFanSpeed" "$(jq '.fans[1].speed' <<<"${data}") rpm"
printf "%-16s: %-16s\n" "topFanSpeed" "$(jq '.fans[2].speed' <<<"${data}") rpm"
printf "%-16s: %-16s\n" "frontFanSpeed" "$(jq '.fans[3].speed' <<<"${data}") rpm"

printf "\n### aquaero temps ###\n"
printf "%-16s: %-16s\n" "waterTemp" "$(jq '.temperatures.sensor[0].temp' <<<"${data}") °C"
printf "%-16s: %-16s\n" "topRadTemp" "$(jq '.temperatures.sensor[1].temp' <<<"${data}") °C"
printf "%-16s: %-16s\n" "bottomRadTemp" "$(jq '.temperatures.sensor[2].temp' <<<"${data}") °C"
printf "%-16s: %-16s\n" "intakeAirTemp" "$(jq '.temperatures.sensor[3].temp' <<<"${data}") °C"
printf "%-16s: %-16s\n" "exhaustAirTemp" "$(jq '.temperatures.sensor[4].temp' <<<"${data}") °C"
