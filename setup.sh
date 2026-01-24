#!/usr/bin/env bash

project_name=${1:-"project"}

echo "Which shell type? 1 : bash | 2 : zsh"
read shell

# Bestimme welche Shell gestartet werden soll
case "$shell" in
    1) shell_cmd="bash" ;;
    2) shell_cmd="zsh" ;;
    *) echo "Invalid choice, defaulting to bash"; shell_cmd="bash" ;;
esac

if [ -n "$IN_NIX_SHELL" ]; then
    echo "Already in Nix shell."
    echo "Shell-Type: $IN_NIX_SHELL"
    [ -n "$NAME" ] && echo "Shell-Name: $NAME"

    # Flutter Projekt erstellen
    flutter create "$project_name"

    # in der Nix-Shell bleiben
    exec "$shell_cmd"

else
    echo "No Nix shell detected. Entering Nix shell..."

    # Nix-Shell starten, Flutter Projekt erstellen, danach in der gewählten Shell bleiben
    nix develop --command "$shell_cmd" -c "
        flutter create '$project_name'
        echo 'Flutter project created. Staying in Nix shell...'
        exec $shell_cmd
    "
fi
