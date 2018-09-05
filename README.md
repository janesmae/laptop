# dotFiles 2.0

This is the "welcome" screen to my .files including vim, zsh, git, and tmux configurations. This branch is for the installer script and installation guide only. Master branch includes all the configs and settings.

Feel free to use it and even make suggestions, however I may decline changes if there's no value to me.

## Install

The recommended way to install my dotFiles is by going through the steps one by one in the *normal mode*. Compared to normal installation procedure, the *expert mode* is faster and probably more error prone.

### Normal Mode

```sh
$ git clone --recursive -b master https://github.com/janesmae/dotfiles.git ~/.files
```

### Expert Mode

(:warning: **DO NOT** run this if you don't fully understand [what it does](install.sh). Seriously, **DON'T**!)

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/install.sh)"
```

## Support

Please [open an issue](https://github.com/janesmae/dotfiles/issues/new/choose) to receive support for this project.

## Contributing

Please read [CONTRIBUTING.md][contributing] for details on our Contribution Guidelines.

The process for submitting pull requests:.

* Fork it!
* Create your feature branch: `git checkout -b my-new-feature`
* Commit your changes: `git commit -am 'Add some feature'`
* Push to the branch: `git push origin my-new-feature`
* Submit a pull request

Also, check out the [CHANGELOG][changelog] for recent changes.

## License

The content of this repository is **&copy; Jaan Janesmae** and released under **MIT License**.<br>
You can find a copy of this license in [LICENSE][license] file or [https://opensource.org/licenses/MIT][license_web].

[contributing]:   ./CONTRIBUTING.md
[license]:        ./LICENSE
[license_web]:    https://opensource.org/licenses/MIT
[changelog]:      ./CHANGELOG.md
