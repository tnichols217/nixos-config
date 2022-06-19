import json

with open("config.json") as f:
    dict = json.load(f)

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

with open("config1.json", "w") as f:
    json.dump(output, f, indent=4)