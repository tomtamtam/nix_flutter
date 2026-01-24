# flutter_nix
Is my nix-flake setup for flutter.

**NOTE:** this manages flutter, setting up android paths, and chromium as chrome executable NOT the android sdk, wich needs to be installed manually through android studio.

## Usage
simply type
```shell
./setup.sh project_name
```
to create a new ptoject and enter the shell

or
```shell
nix develop
```

to enter the nix shell without creating a project

## Install Android
- installl android studio
- in android studio: More Actions -> SDK Manager -> SDK Tools -> check Android SDK Build-Tools, Android SDK Command-line Tools (latest), Android Emulator, Android SDK Platform Tools
