{ ... }:
{
  # networking.wg-quick.interfaces = {
  #    wg0 = {
  #      address = [ "192.168.1.1/24" "fdc9:281f:04d7:9ee9::2/64" ];
  #      dns = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ];
  #      privateKeyFile = "/root/wireguard-keys/privatekey";
  #
  #      peers = [
  #        {
  #          publicKey = "{server public key}";
  #          presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
  #          allowedIPs = [ "0.0.0.0/0" "::/0" ];
  #          endpoint = "{server ip}:51820";
  #          persistentKeepalive = 25;
  #        }
  #      ];
  #    };
  #  };
  #
}
