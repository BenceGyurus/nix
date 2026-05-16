{ pkgs, ... }: 
let
  # Itt definiálod a saját egyedi Java csomagodat
  tlauncher = pkgs.stdenv.mkDerivation rec {
    pname = "minta-alkalmazas";
    version = "core-1.266-v2";

    src = pkgs.fetchurl {
      url = "https://dl1.tlauncher.org/f.php?f=files%2Fstarter-${version}.jar";
      sha256 = "sha256-zYO9Nwj10iJrQnERddTL9cVymuKblX7l/Y6VKEhjyls="; 
    };

    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildInputs = [ pkgs.jre ];

    installPhase = ''
      mkdir -p $out/share/java
      mkdir -p $out/bin
      cp $src $out/share/java/TLauncher.jar
      makeWrapper ${pkgs.jre}/bin/java $out/bin/TLauncher.jar \
        --add-flags "-jar $out/share/java/TLauncher.jar"
    '';
  };
in {

  environment.systemPackages = [
    tlauncher
  ];
}