pdftotext data-hold/California-Condemned-Inmate-List -layout
cat data-hold/California-Condemned-Inmate-List.txt| grep -oE 'Living.............' | grep -oE '\b[[:alpha:]]{3}\b'
