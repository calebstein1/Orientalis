#!/bin/sh

r=0
ttop=$(grep -o 'ttop([0-9]*)' $1)
for inst in $ttop; do
    n=${inst#ttop(}
    n=${n%)}
    n=$((n*8))
    sed -i '' "s/${inst}/${n}/" $1 && r=$((r+1))
done

echo "Replaced $r instances"
