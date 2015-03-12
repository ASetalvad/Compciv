mkdir -p data-hold/geocodes
cp /dev/null tables/geocodes.psv
echo "location|latitude|longitute" > tables/geocodes.psv

for HTMLFILE in data-hold/*.html
do
	YEAR=$(echo ${HTMLFILE} | cut -d'.' -f1 | cut -d'_' -f2)
	YEAR=$(basename ${YEAR})

	if [[ "${YEAR}" == "ois" ]]
	then
		grep -A1 -E "[0-9]?*/[0-9]?*/2013" ${HTMLFILE} | sed '0~3d' | sed '1d;n;d' | cut -d'>' -f2 | cut -d'<' -f1 > locations-2013.txt
		grep -A1 -E "[0-9]?*/[0-9]?*/2014" ${HTMLFILE} | sed '0~3d' | sed '1d;n;d' | cut -d'>' -f2 | cut -d'<' -f1 > locations-2014.txt
	else
		grep -A1 -E "[0-9]?*/[0-9]?*/${YEAR}" ${HTMLFILE} | sed '0~3d' | sed '1d;n;d' | cut -d'>' -f2 | cut -d'<' -f1 > locations-${YEAR}.txt
	fi
done

for LOCFILE in locations-*.txt
do
	while read LINE
	do
		LOCSTRING=$(echo $LINE | sed s/[^A-Za-z0-9]//g)
		JSONFILE="data-hold/geocodes/${LOCSTRING}.json"
		GEOSTRING=$(echo $LINE | sed 's/ /\+/g' | sed 's/#//g' | sed 's/++/+/g' | sed 's/\.//g')
		GEOSTRING="${GEOSTRING}+Dallas+TX"

		if [[ -s "${JSONFILE}" ]]
		then
			echo "File ${JSONFILE} already downloaded"
		else
			echo "Going to geocode the file"
			echo "Geostring is ${GEOSTRING}"
			curl "https://maps.googleapis.com/maps/api/geocode/json?address=${GEOSTRING}" > ${JSONFILE}
			sleep 4
		fi 

		LAT=$(cat ${JSONFILE} | grep -A2 '\"location\"' | head -3 | grep "lat" | sed 's/ //g' | sed 's/,//' | awk -F: '{print $2}')
		LNG=$(cat ${JSONFILE} | grep -A2 '\"location\"' | head -3 | grep "lng" | sed 's/ //g' | sed 's/,//' | awk -F: '{print $2}')

		echo "${LINE}|${LAT}|${LNG}" >> tables/geocodes.psv
		echo "${LINE}|${LAT}|${LNG} added geocodes.psv"

		echo "Total lines: $(wc -l tables/geocodes.psv)"
		tail -1 tables/geocodes.psv
	done < ${LOCFILE}
done

