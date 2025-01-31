{ pkgs, config, username, addresses, host-name, ... }:
{
  # systemd.services."${username}@sunshine" = {
  #   serviceConfig.Type = "simple";
  #   path = with pkgs; [ pkgs.sunshine ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.sunshine}/bin/sunshine";
  #     Restart = "on-failure";
  #   };
  #   serviceConfig = {
  #     Environment = "\"HOME=/home/${username}\" XDG_CONFIG_HOME=/home/${username}/.config";
  #   };
  #   wantedBy = ["multi-user.target"];
  # };
  systemd.services."${username}@cachix" = {
    serviceConfig.Type = "simple";
    path = with pkgs; [ pkgs.cachix ];
    serviceConfig = {
      ExecStart = "${pkgs.cachix}/bin/cachix watch-store tnichols217-nixos-config";
      Restart = "on-failure";
    };
    serviceConfig.User = "${username}";
    wantedBy = ["multi-user.target"];
  };
  # users.users.jupyter.group = "jupyter";
  # users.groups.jupyter = {};
  # services.jupyter = {
  #   enable = true;
  #   password = "'argon2:$argon2id$v=19$m=10240,t=10,p=8$8fwdJqzs0V17f2Sh0fpzjg$z8mpfURqs6Zfl67DYdqZjdhDPgufg8yVjzRvjHamQUY'";
  #   kernels = {
  #     python3 = let
  #       env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
  #               ipykernel
  #               pandas
  #               scikit-learn
  #               pip
  #               numpy
  #               scipy
  #               matplotlib
  #               notebook
  #             ]));
  #     in {
  #       displayName = "Python 3 for machine learning";
  #       argv = [
  #         "${env.interpreter}"
  #         "-m"
  #         "ipykernel_launcher"
  #         "-f"
  #         "{connection_file}"
  #       ];
  #       language = "python";
  #     };
  #   };
  # };
}