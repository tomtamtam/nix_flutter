{
  description = "Flutter dev environment on NixOS with Android support";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [ 
        (pkgs.buildFHSEnv {
          name = "flutter-android-fhs";
          targetPkgs = pkgs: with pkgs; [
            flutter
            chromium
            gtk3
            glib
            mesa-demos
            jdk17
            # Bibliotheken für Android Tools
            zlib
            ncurses5
            stdenv.cc.cc.lib
            libGL
            glibc
          ];
          multiPkgs = pkgs: with pkgs; [
            zlib
            ncurses5
          ];
          runScript = "bash";
          profile = ''
            export CHROME_EXECUTABLE=chromium
            export ANDROID_HOME=$HOME/Android/Sdk
            export ANDROID_SDK_ROOT=$HOME/Android/Sdk
            export JAVA_HOME=${pkgs.jdk17}
            export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH
          '';
        })
      ];
      shellHook = ''
        echo "Entering FHS environment for Flutter with Android..."
        echo "Type 'flutter-android-fhs' to enter the environment"
        flutter-android-fhs
      '';
    };
  };
}
