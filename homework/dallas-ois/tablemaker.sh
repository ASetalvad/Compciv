ISFILE="data-hold/ois_2003.html"

echo "case_number|date|location|suspect_status|suspect_weapon|suspects|officers|grand_jury|latitude|logitude|narrative" > tables/incidents.psv

grep -A8 pdf data-hold/ois_2012.html | sed 's/<\/tr[^>]*>//g' | sed 's/<td[^>]*>/\|/g' | sed 's/<\/td[^>]*>//g' > temp-incidents.txt

