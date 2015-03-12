# First download the pdfs from the current year's page
lynx --dump ${URL}/${HTMLFILECURRENT} | awk '/http/{print $2}' | grep pdf > current.txt

mkdir -p data-hold/pdfs

for PDF in $(cat current.txt)
do
	wget -P data-hold/pdfs/ ${PDF}
done

# Download the current ois html file to data-hold directory
wget -P data-hold/ ${URL}/${HTMLFILECURRENT}

# Next download the pdfs from past year pages
for YEAR in $(seq 2003 2012)
do
	HTMLFILE="ois_${YEAR}.html"
	TXTFILE="${YEAR}.txt"

	lynx --dump ${URL}/${HTMLFILE} | awk '/http/{print $2}' | grep pdf > ${YEAR}.txt

	for PDF in $(cat ${YEAR}.txt)
	do
		wget -P data-hold/pdfs/ ${PDF}
done
