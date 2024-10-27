{ lib }:
rec {
  mainGateway = "192.168.1.1"; # main router
  defaultGateway = "192.168.2.1";
  nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
  prefixLength = 24;

  hostsAddr = {
    server1 = {
      iface = "eno1";
      ipv4 = "192.168.2.101";
    };
    server2 = {
      iface = "eno1";
      ipv4 = "192.168.2.102";
    };
    server3 = {
      iface = "eno1";
      ipv4 = "192.168.2.103";
    };
  };

  hostsInterface = lib.attrsets.mapAttrs (key: val: {
    interfaces."${val.iface}" = {
      useDHCP = false;
      ipv4.addresses = [
        {
          inherit prefixLength;
          address = val.ipv4;
        }
      ];
    };
  }) hostsAddr;

  ssh = {
    # define the host alias for remote builders
    # this config will be written to /etc/ssh/ssh_config
    # ''
    #   Host server1
    #     HostName 192.168.2.100
    #     Port 22
    #
    #   Host server2
    #     HostName 192.168.2.101
    #     Port 22
    #   ...
    # '';
    extraConfig = lib.attrsets.foldlAttrs (
      acc: host: val:
      acc
      + ''
        Host ${host}
          HostName ${val.ipv4}
          Port 22
      ''
    ) "" hostsAddr;

    # define the host key for remote builders so that nix can verify all the remote builders
    # this config will be written to /etc/ssh/ssh_known_hosts
    knownHosts =
      # Update only the values of the given attribute set.
      #
      #   mapAttrs
      #   (name: value: ("bar-" + value))
      #   { x = "a"; y = "b"; }
      #     => { x = "bar-a"; y = "bar-b"; }
      lib.attrsets.mapAttrs
        (host: value: {
          hostNames = [
            host
            hostsAddr.${host}.ipv4
          ];
          publicKey = value.publicKey;
        })
        {
          server1.publicKey = "";
          server2.publicKey = "";
          server3.publicKey = "";
        };
  };
}
