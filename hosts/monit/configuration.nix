{
  modulesPath,
  config,
  inputs,
  unstable,
  myvars,
  ...
}:
let
  inherit (myvars.networking) hostsAddr ip;
  inherit (hostsAddr.monit) name home-modules profiles;
  addr = hostsAddr.monit.ip;
in
{
  imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];

  networking.firewall.allowedTCPPorts = [
    config.services.grafana.settings.server.http_port
    config.services.prometheus.port
  ];

  dsn = {
    common.enable = true;
  };

  boot.isContainer = true;
  programs.zsh.enable = true;
  services.qemuGuest.enable = true;

  networking = {
    usePredictableInterfaceNames = false;
    hostName = name;
    enableIPv6 = false;
    interfaces.eth0.ipv4.addresses = [
      {
        address = addr;
        prefixLength = 24;
      }
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      unstable = unstable "x86_64-linux";
      inherit inputs myvars;
    };

    sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

    users.dsn.imports = home-modules ++ profiles;
  };

  system = {
    stateVersion = "24.11";
  };

  # prometheus: port 3020 (8020)
  #
  services.prometheus = {
    port = 3020;
    enable = true;

    exporters = {
      node = {
        enable = true;
        listenAddress = "0.0.0.0";
        port = 3021;
        enabledCollectors = [
          "systemd"
          "logind"
        ];
      };
    };

    # ingest the published nodes
    scrapeConfigs = [
      {
        job_name = "nodes";
        static_configs = [
          { targets = [ "${ip.loopback}:${toString config.services.prometheus.exporters.node.port}" ]; }
        ];
      }
    ];
  };

  # loki: port 3030 (8030)
  #
  # services.loki = {
  #   enable = true;
  #   configuration = {
  #     server.http_listen_port = 3030;
  #     auth_enabled = false;
  #
  #     ingester = {
  #       lifecycler = {
  #         address = "127.0.0.1";
  #         ring = {
  #           kvstore = {
  #             store = "inmemory";
  #           };
  #           replication_factor = 1;
  #         };
  #       };
  #       chunk_idle_period = "1h";
  #       max_chunk_age = "1h";
  #       chunk_target_size = 999999;
  #       chunk_retain_period = "30s";
  #       max_transfer_retries = 0;
  #     };
  #
  #     schema_config = {
  #       configs = [
  #         {
  #           from = "2022-06-06";
  #           store = "boltdb-shipper";
  #           object_store = "filesystem";
  #           schema = "v11";
  #           index = {
  #             prefix = "index_";
  #             period = "24h";
  #           };
  #         }
  #       ];
  #     };
  #
  #     storage_config = {
  #       boltdb_shipper = {
  #         active_index_directory = "/var/lib/loki/boltdb-shipper-active";
  #         cache_location = "/var/lib/loki/boltdb-shipper-cache";
  #         cache_ttl = "24h";
  #         shared_store = "filesystem";
  #       };
  #
  #       filesystem = {
  #         directory = "/var/lib/loki/chunks";
  #       };
  #     };
  #
  #     limits_config = {
  #       reject_old_samples = true;
  #       reject_old_samples_max_age = "168h";
  #     };
  #
  #     chunk_store_config = {
  #       max_look_back_period = "0s";
  #     };
  #
  #     table_manager = {
  #       retention_deletes_enabled = false;
  #       retention_period = "0s";
  #     };
  #
  #     compactor = {
  #       working_directory = "/var/lib/loki";
  #       shared_store = "filesystem";
  #       compactor_ring = {
  #         kvstore = {
  #           store = "inmemory";
  #         };
  #       };
  #     };
  #   };
  #   # user, group, dataDir, extraFlags, (configFile)
  # };

  # promtail: port 3031 (8031)
  #
  # services.promtail = {
  #   enable = true;
  #   configuration = {
  #     server = {
  #       http_listen_port = 3031;
  #       grpc_listen_port = 0;
  #     };
  #     positions = {
  #       filename = "/tmp/positions.yaml";
  #     };
  #     # clients = [
  #     #   {
  #     #     url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}/loki/api/v1/push";
  #     #   }
  #     # ];
  #     scrape_configs = [
  #       {
  #         job_name = "journal";
  #         journal = {
  #           max_age = "12h";
  #           labels = {
  #             job = "systemd-journal";
  #             host = "pihole";
  #           };
  #         };
  #         relabel_configs = [
  #           {
  #             source_labels = [ "__journal__systemd_unit" ];
  #             target_label = "unit";
  #           }
  #         ];
  #       }
  #     ];
  #   };
  #   # extraFlags
  # };

  # grafana: port 3010 (8010)
  #
  services.grafana = {
    port = 3010;
    # WARNING: this should match nginx setup!
    # prevents "Request origin is not authorized"
    rootUrl = "http://${addr}:8010"; # helps with nginx / ws / live

    protocol = "http";
    addr = ip.loopback;
    analytics.reporting.enable = false;
    enable = true;

    provision = {
      enable = true;

      datasources = {
        settings = {
          datasources = [
            {
              name = "Prometheus";
              type = "prometheus";
              access = "proxy";
              url = "http://${ip.loopback}:${toString config.services.prometheus.port}";
            }
            # {
            #   name = "Loki";
            #   type = "loki";
            #   access = "proxy";
            #   url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}";
            # }
          ];
        };
      };
    };
  };

  # nginx reverse proxy
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    # recommendedTlsSettings = true;

    upstreams = {
      "grafana" = {
        servers = {
          "${ip.loopback}:${toString config.services.grafana.port}" = { };
        };
      };
      "prometheus" = {
        servers = {
          "${ip.loopback}:${toString config.services.prometheus.port}" = { };
        };
      };
      # "loki" = {
      #   servers = {
      #     "127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}" = { };
      #   };
      # };
      # "promtail" = {
      #   servers = {
      #     "127.0.0.1:${toString config.services.promtail.configuration.server.http_listen_port}" = { };
      #   };
      # };
    };

    virtualHosts.grafana = {
      locations."/" = {
        proxyPass = "http://grafana";
        proxyWebsockets = true;
      };
      listen = [
        {
          inherit addr;
          port = 8010;
        }
      ];
    };

    virtualHosts.prometheus = {
      locations."/".proxyPass = "http://prometheus";
      listen = [
        {
          inherit addr;
          port = 8020;
        }
      ];
    };

    # confirm with http://192.168.1.10:8030/loki/api/v1/status/buildinfo
    #     (or)     /config /metrics /ready
    # virtualHosts.loki = {
    #   locations."/".proxyPass = "http://loki";
    #   listen = [
    #     {
    #       inherit addr;
    #       port = 8030;
    #     }
    #   ];
    # };

    # virtualHosts.promtail = {
    #   locations."/".proxyPass = "http://promtail";
    #   listen = [
    #     {
    #       inherit addr;
    #       port = 8031;
    #     }
    #   ];
    # };
  };
}
