# Imports current system's kde config and exports it to config.json

from pathlib import Path
import json
import os

HOME = os.path.expanduser('~')

def listToDict(l):
    o = {}
    [o.__setitem__(i[0], i[1] if len(i) > 1 else "") for i in l]
    return o

def readFile(f):
    with open(f, 'r') as f:
        o = f.readlines()
        oo = []
        [oo.append(i) if (len(i) > 0 and not i.startswith("#") and not i.startswith("\n")) else () for i in o]
        f.close()
        ooo = "".join(oo)
        return ooo[:len(ooo)-1]

def parseString(c):
    DELIM = "\n["
    DELIM2 = "]["
    d = [[(i[0][:len(i[0])-1].split(DELIM2)), listToDict([j.split("=") for j in i[1:]])] for i in [i.split("\n") for i in c.split(DELIM)[1:]]]
    return d

def parseFile(f):
    c = " \n" + readFile(f)
    return parseString(c)

def remove(s, r):
    o = s
    for i in r:
        o = o.replace(str(i), "")
    return o

CONFIGDIR = [Path(HOME + "/.config"), Path("/etc/xdg")]
MATCHES = ["*rc", "*kdeglobals", "Trolltech.conf"]

files = []
dict = {}
dict.__setitem__("config", parseFile("config"))

output = {}
for q in dict:
    o = {}
    for i in dict[q]:
        if (not i[0][0] in o):
            o[i[0][0]] = {}
        loc = o[i[0][0]]
        for k in i[0][1:]:
            if (not "groups" in loc):
                loc["groups"] = {k: {}}
            elif (not k in loc["groups"]):
                loc["groups"][k] = {}
            loc = loc["groups"][k]
        if (len(i[1]) > 0 and not "items" in loc):
            loc["items"] = {}
            loc = loc["items"]
        for k in i[1]:
            loc[k] = i[1][k]
    output[q] = o

with open("./config1.json", "w") as f:
    json.dump(output, f, indent=4)
