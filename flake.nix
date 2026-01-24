{
  description = "Flutter dev environment on NixOS with Android support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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
      buildInputs = with pkgs; [
        flutter
        chromium
        gtk3
        glib
        mesa-demos

        # Android SDK / tools
        androidsdk.commandlinetools
        androidsdk.platform-tools
      ];

      # Environment variables für Android SDK
      ANDROID_SDK_ROOT = "${pkgs.androidsdk}";
      PATH = "${pkgs.androidsdk.platform-tools}/bin:${pkgs.androidsdk.commandlinetools}/bin:$PATH";

      # Für Flutter Web
      CHROME_EXECUTABLE = "chromium";

      shellHook = ''
        echo "Flutter + Android dev shell ready"
        flutter --version

        yes | flutter doctor --android-licenses 2>/dev/null || true
      '';
    };
  };
}

