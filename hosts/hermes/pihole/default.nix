{...}: {
  virtualisation.oci-containers.containers = {
    pihole = {
      image = "docker.io/pihole/pihole:2023.10.0";
      autoStart = true;
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "67:67/udp"
        "80:80/tcp"
      ];
      environment = {
        TZ = "UTC";
        WEBPASSWORD = "password123";
      };
    };
  };
}
