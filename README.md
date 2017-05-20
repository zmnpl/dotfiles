# My dotfiles

## Story

I'm managing my dotfiles/vim plugins here. If you want to try them, follow section Usage.

## Usage

    cd
	git clone https://github.com/zmnpl/dotfiles
	cd dotfiles
	./install.sh

A backup of all files replaced will be copied to ~/dotfiles/backup, but only if those were not symbolic links. I'm using zsh as shell, so my dotfiles will work best with that.
Be aware, that the install script will clone certain vim plugins as well as my fork of zprezto (where I only maintain a custom rc file). All the credit belongs to the developers of these things.

## Disclaimer

Feel free to try my dotfiles/configuration copy and modify them as you like. Be aware, that installation as well clones multiple repositories of other developers like vim plugins etc.
Use on your own risk. Do not make me responsible for damage caused to your system or data caused by using this.
