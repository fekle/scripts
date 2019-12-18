#!/usr/bin/env bash
set -euf -o pipefail

# discover mounted btrfs filesystems
filesystems=$(mount | grep ' btrfs ' | awk '{print $3}' | uniq | sort -h)

# print table header
printf '    decompressed        compressed      ratio    reduction   filesystem \n'

# vars
alltotal=0
allused=0
i=0

# loop trough btrfs filesystems
for fs in ${filesystems[*]}; do
  # get raw data from btrfs
  df=$(btrfs filesystem df "${fs}" -b | head -n 1)

  # get total and used bytes
  total=$(grep -o 'total=[0-9]\+' <<<"${df}" | grep -o '[0-9]\+')
  used=$(grep -o 'used=[0-9]\+' <<<"${df}" | grep -o '[0-9]\+')

  alltotal=$((alltotal + total))
  allused=$((allused + used))

  # calculate ratio and percent
  ratio=$(printf "%.2f" $(bc -l <<<"${total}/${used}"))
  percent=$(printf "%.0f" $(bc -l <<<"100-((${used}/${total})*100)"))

  # format and print data
  printf ' %6s   %6s   %6s   %6s   %8s   %10s   %-s \n' "$(numfmt --to=si ${total})B" "$(numfmt --to=iec ${total})iB" "$(numfmt --to=si ${used})B" "$(numfmt --to=iec ${used})iB" "${ratio}x" "${percent}%" "${fs}"

  # let's be nice to btrfs
  sleep .01
done

#alltotal=$((${alltotal} / ${#filesystems}))
#allused=$((${allused} / ${#filesystems}))

ratio=$(printf "%.2f" $(bc -l <<<"${alltotal}/${allused}"))
percent=$(printf "%.0f" $(bc -l <<<"100-((${allused}/${alltotal})*100)"))
printf '\n %6s   %6s   %6s   %6s   %8s   %10s   %-s \n' "$(numfmt --to=si ${alltotal})B" "$(numfmt --to=iec ${alltotal})iB" "$(numfmt --to=si ${allused})B" "$(numfmt --to=iec ${allused})iB" "${ratio}x" "${percent}%" "TOTAL"
