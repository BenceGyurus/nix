({ pkgs, ... }: 
    let
    polymc-mac = pkgs.stdenv.mkDerivation rec {
    pname = "polymc";
    version = "7.0"; 
    src = pkgs.fetchurl {
        url = "https://github.com/PolyMC/PolyMC/releases/download/${version}/PolyMC-macOS-${version}.tar.gz";
        sha256 = "sha256-s6dPI0leaEWsDwsPKwi4qLfKLbUAEpM1eakkRX5LQj4="; 
    };

    sourceRoot = ".";

    installPhase = ''
        mkdir -p $out/Applications
        cp -r PolyMC.app $out/Applications/
        '';
    };
    in {
    environment.systemPackages = [ polymc-mac ];
})