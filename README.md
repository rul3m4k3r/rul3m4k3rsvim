# vim folder and vimrc file

first install mvim via brew

    brew install macvim --override-system-vim

add enter following lines in your ~ dir

    ln -s rul3m4k3rsVim/ .vim
    ln -s rul3m4k3rsVim/.vimrc .vimrc

    cd rul3m4k3rsVim
    git submodule update --init --recursive

open vim and run

    :BundleInstall

close vim and run

    brew install CMake
    cd bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.sh

    brew install ack
Keybindings:

	Tasklist: ,+t
	NerdTree: ctrl+n
        omnicompletion: ctrl+space

Colorscheme: xoria256
