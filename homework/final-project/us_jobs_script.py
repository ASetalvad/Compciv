from os import listdir
from os.path import isfile, join
import os
import json

mypath=os.path.expanduser("~/compciv/homework/usjobsgov/data-hold/scrapes/2015-02-28_1500")
# for loop that picks out regular files within specified directory
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath, f)) ]

# >>> onlyfiles[0]
# '0000-1.json'
p = join (mypath, onlyfiles[0])
print p
f = open (p, "r")
print f
lines = f.read()
j=json.loads (lines)
#j ['JobData'][0].keys()
cyber_jobs = []
for job in j["JobData"]:
	print job["JobSummary"]
