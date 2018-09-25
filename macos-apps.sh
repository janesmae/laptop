#!/usr/bin/env sh

case "$(uname)" in
	Darwin)

# Install apps using Brew bundle
brew bundle install --file=- <<_BREW
$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/Brewfile)
_BREW

	;;
esac
