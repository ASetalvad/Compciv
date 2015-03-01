from os import listdir
from os.path import isfile, join


mypath=listdir(".")[1]
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath, f)) ]

# >>> onlyfiles[0]
# '0000-1.json'
p = join (mypath, onlyfiles[0])
f = open (p, "r")
lines = f.read()
