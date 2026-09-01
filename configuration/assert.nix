{ config, lib, ... }:

let
  # Extract all non-root, non-systemd-DynamicUser accounts
  usersMissingUid = lib.filterAttrs (name: user:
      name != "root" && user.uid == null
    ) config.users.users;

  groupsMissingGid = lib.filterAttrs (name: group:
    # Catch any group where gid is not set
    group.gid == null
  ) config.users.groups;

in {
  assertions = [
    {
      assertion = usersMissingUid == {};
      message = ''
        Build failed: The following users are missing explicit static UIDs:
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: _: "  - ${name}") usersMissingUid)}

        Please define `users.users.<name>.uid` explicitly to maintain stateless compatibility.
      '';
    }
    {
      assertion = groupsMissingGid == {};
      message = ''
        Build failed: The following groups are missing explicit static GIDs:
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: _: "  - ${name}") groupsMissingGid)}

        Please define `users.groups.<name>.gid` explicitly to maintain stateless compatibility.
      '';
    }
  ];
}
