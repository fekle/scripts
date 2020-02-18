#!/usr/bin/env bash
set -euf -o pipefail

data=$(curl -Ls http://localhost:9500/status)

printf "=== Fan Speeds ===\n"
printf "%-16s %-.0f rpm\n" "Pump" "$(jq '.fans[0].speed' <<<"${data}")"
printf "%-16s %-.0f rpm\n" "Top Fans" "$(jq '.fans[1].speed' <<<"${data}")"
printf "%-16s %-.0f rpm\n" "Bottom Fans" "$(jq '.fans[2].speed' <<<"${data}")"
printf "%-16s %-.0f rpm\n" "Front Fans" "$(jq '.fans[3].speed' <<<"${data}")"

printf "\n=== Temperatures ===\n"
printf "%-16s %-.0f °C\n" "Water" "$(jq '.temperatures.sensor[0].temp' <<<"${data}")"
printf "%-16s %-.0f °C\n" "Top Rad" "$(jq '.temperatures.sensor[1].temp' <<<"${data}")"
printf "%-16s %-.0f °C\n" "Bottom Rad" "$(jq '.temperatures.sensor[2].temp' <<<"${data}")"
printf "%-16s %-.0f °C\n" "Intake Air" "$(jq '.temperatures.sensor[3].temp' <<<"${data}")"
printf "%-16s %-.0f °C\n" "Exhaust Air" "$(jq '.temperatures.sensor[4].temp' <<<"${data}")"
