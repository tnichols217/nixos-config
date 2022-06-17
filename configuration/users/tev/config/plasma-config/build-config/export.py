# exports config.json into a shell script using writeconfig5

import json

with open("./config.json") as f:
    j = json.load(f)

def san(s):
    return s.replace("$", "\\$").replace("\"", "\\\"").replace("`", "\\`")

o = ""
for filename in j:
    for group in j[filename]:
        for l in group[1]:
            o += "$1 --file \"" + "`pwd`/conf" + san(filename)  + "\" --group \"" + "\" --group \"".join([san(i) for i in group[0]]) + "\" --key \"" + san(l) + "\" \"" + san(group[1][l]) + "\"\n"

with open("./config.sh", "w") as f:
    f.write(o)