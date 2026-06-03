{ inputs, ... }:
{
  perSystem = { config, self', pkgs, ... }:
    let
      quickshell = inputs.quickshell.packages.${pkgs.system}.default.override {
        withWayland = true;
        withHyprland = true;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        name = "primary-shell";
        inputsFrom = [
          self'.devShells.rust
          config.pre-commit.devShell
        ];
        packages = with pkgs; [
          just
          nixd
          bacon
          quickshell
          qt6.qtdeclarative
          qt6.qt5compat
          qt6.qtshadertools
        ];
        shellHook = ''
          export QML2_IMPORT_PATH="${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${quickshell}/lib/qt-6/qml:${pkgs.qt6.qt5compat}/lib/qt-6/qml"
          export QML_IMPORT_PATH="$QML2_IMPORT_PATH"
          export PATH="$PWD/.bin:$PATH"
          export QMLLS_BUILD_DIRS=/nix/store/lwa1k7ni8d4ljj44mzzlagk4qnngrsr8-qtdeclarative-6.11.0/lib/qt-6/qml/
          mkdir -p $PWD/.bin
          printf '#!/bin/sh\nexec ${pkgs.qt6.qtdeclarative}/bin/qmlls -E "$@"\n' > $PWD/.bin/qmlls
          chmod +x $PWD/.bin/qmlls
        '';
      };
    };
}
