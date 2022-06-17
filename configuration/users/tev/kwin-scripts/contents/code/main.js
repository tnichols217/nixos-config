function halfRight(client) {
    client.geometry.width = Math.round(client.geometry.width/2);
}

function halfDown(client) {
    client.geometry.height = Math.round(client.geometry.height/2);
}

function halfLeft(client) {
    client.geometry.x += Math.round(client.geometry.width/2);
    client.geometry.width = Math.round(client.geometry.width/2);
}

function halfUp(client) {
    client.geometry.y += Math.round(client.geometry.height/2);
    client.geometry.height = Math.round(client.geometry.height/2);
}

registerShortcut("Resize Window to Half Up",
                 "Resize Window to Half Up",
                 "Meta+W",
                 () => {
                     halfUp(workspace.activeClient);
                 });
registerShortcut("Resize Window to Half Left",
                 "Resize Window to Half Left",
                 "Meta+A",
                 () => {
                     halfLeft(workspace.activeClient);
                 });
registerShortcut("Resize Window to Half Down",
                 "Resize Window to Half Down",
                 "Meta+S",
                 () => {
                     halfDown(workspace.activeClient);
                 });
registerShortcut("Resize Window to Half Right",
                 "Resize Window to Half Right",
                 "Meta+D",
                 () => {
                     halfRight(workspace.activeClient);
                 });
