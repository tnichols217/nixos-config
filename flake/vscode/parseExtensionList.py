import json

# extensions.conf can be generated with `code --list-extensions --show-versions`
with open("./extensions.conf", "r") as f:
    s = f.read()
    i = [j for j in s.split("\n")]

exts = [k[0].split(".") + [k[1]] for k in [j.split("@") for j in i]]

def name(ext):
    return "vscExt-" + ext[0] + "-" + ext[1]

def extLink(ext):
    return "https://" + ext[0] + ".gallery.vsassets.io/_apis/public/gallery/publisher/" + ext[0] + "/extension/" + ext[1] + "/" + ext[2] + "/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"

def genFlakeInfo(ext):
    return name(ext) + ''' = {
  url = "''' + extLink(ext) + '''";
  flake = false;
};\n'''

def genExtList(ext):
    return '''{
  vsix = vscodeExtensions.''' + name(ext) + ''';
  mktplcRef = {
    publisher = "''' + ext[0] + '''";
    name = "''' + ext[1] + '''";
    version = "''' + ext[2] + '''";
  };
}\n'''

def genAttrList(ext):
    return '''  ''' + name(ext) + '''\n'''

# links = "".join(list(map(genFlakeInfo, exts)))
# links = "".join(list(map(genExtList, exts)))
links = "".join(list(map(genAttrList, exts)))
print(links)