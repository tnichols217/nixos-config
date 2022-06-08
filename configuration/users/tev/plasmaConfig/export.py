# exports config.json into a shell script using writeconfig5

import json
import os

CUR = os.getcwd()
with open("./config.json") as f:
    j = json.load(f)

def san(s):
    return s.replace("$", "\\$").replace("\"", "\\\"").replace("`", "\\`")

o = ""
for i in j:
    for k in j[i]:
        for l in k[1]:
            if (len(l) == 2):
                o += "kwriteconfig5 --file \"" + CUR + "/conf" + san(i)  + "\" --group \"" + "\" --group \"".join([san(i) for i in k[0]]) + "\" --key \"" + san(l[0]) + "\" \"" + san(l[1]) + "\"\n"

with open("./config.sh", "w") as f:
    f.write(o)