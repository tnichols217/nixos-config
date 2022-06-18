import json

with open("./config.json") as f:
    j = json.load(f)

def parseGroups(s):
    o = []
    for i in s:
        o += [[i] + j for j in parseStruct(s[i])]
    
    return o

def parseStruct(s):
    o = []
    if "items" in s:
        o += [[i, s["items"][i]] for i in s["items"]]
    if "groups" in s:
        o += parseGroups(s["groups"])

    return o

def san(s):
    return s.replace("$", "\\$").replace("\"", "\\\"").replace("`", "\\`")

output = []
for i in j:
    output += [[i] + k for k in parseGroups(j[i])]

sh = ""
for i in output:
    sh += "$1 --file \"" + "`pwd`/conf" + san(i[0])  + "\" --group \"" + "\" --group \"".join([san(k) for k in i[1:-2]]) + "\" --key \"" + san(i[-2]) + "\" \"" + san(i[-1]) + "\"\n"

with open("./config.sh", "w") as f:
    f.write(sh)