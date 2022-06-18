import json
with open("config.json") as f:
    a = json.dumps(json.load(f), indent=2).split("\n")

def parseLine(s):
    o = s
    o = o.replace("\":", "\"=")
    o = o.replace(",", "")
    o = o.replace("\n", "")
    if (not o.endswith("{")):
        o += ";"
    return o

a = [parseLine(i) for i in a]


with open("config.nix", "w") as f:
    f.write("\n".join(a)[:-1])