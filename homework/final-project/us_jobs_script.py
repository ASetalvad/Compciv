from os import listdir
from os.path import isfile, join
import os
import json

mypath=os.path.expanduser("~/compciv/homework/usjobsgov/data-hold/scrapes/2015-02-28_1500")
# for loop that picks out regular files within specified directory
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath, f)) ]
cyber_jobs = []
# >>> onlyfiles[0]
# '0000-1.json'
for file_name in onlyfiles:
	p = join (mypath, file_name)
	print p
	f = open (p, "r")
	print f
	lines = f.read()
	j=json.loads (lines)
	#j ['JobData'][0].keys()
	#job postings that contain keywords in Job Summary are put in cyber_jobs list
	keywords=["cyber", "cybersecurity", "cyber security", "cyber-security", "cyber risk", "cyber breach", "cyber threat", "data breach"]
	for job in j["JobData"]:
		print job["JobSummary"]
		for keyword in keywords:
			if keyword in job["JobSummary"]:
				cyber_jobs.append(job)
print "number of cyber jobs found:", len(cyber_jobs)