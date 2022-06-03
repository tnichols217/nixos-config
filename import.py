from pathlib import Path
import json

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

CONFIGDIR = [Path("/home/tev/.config"), Path("/etc/xdg")]
MATCHES = ["*rc", "*kdeglobals"]

files = []
dict = {}
[[[ dict.__setitem__(str(i), parseFile(i)) for i in i.glob(j)] for j in MATCHES] for i in CONFIGDIR]

with open("./config.json", "w") as f:
    json.dump(dict, f)
