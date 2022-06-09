# Imports current system's kde config and exports it to config.json

# Transform local config into global configs (multiuser)
transform = False

from pathlib import Path
import json
import os

HOME = os.path.expanduser('~')

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
    d = [[(i[0][:len(i[0])-1].split(DELIM2)), [j.split("=") for j in i[1:]]] for i in [i.split("\n") for i in c.split(DELIM)[1:]]]
    # print(d)
    return d

def parseFile(f):
    c = " \n" + readFile(f)
    return parseString(c)

CONFIGDIR = [Path(HOME + "/.config"), Path("/etc/xdg")]
MATCHES = ["*rc", "*kdeglobals", "Trolltech.conf"]

files = []
dict = {}
[[[ dict.__setitem__(str(i), parseFile(i)) for i in i.glob(j)] for j in MATCHES] for i in CONFIGDIR]

if (transform):
    o = {}
    for k in dict:
        if (k.startswith("/home")):
            transformed = "/etc/xdg/" + "/".join(k.split("/")[4:])
            if transformed in o.keys():
                o[transformed] += dict[k]
            else:
                o[transformed] = dict[k]
        else:
            if k in o.keys():
                o[k] += dict[k]
            else:
                o[k] = dict[k]
    dict = o

print(dict.keys())

with open("./config1.json", "w") as f:
    json.dump(dict, f)
