# c311-get-started

This document will serve as an (opinionated) guide for setting up Racket and Emacs on a Mac.

## 1. Get Racket
1. Download the latest version of Racket from http://download.racket-lang.org/. Make sure you choose "Racket" as the distribution; the platform should probably just be "Mac OS X (Intel 64-bit)".
2. Open the downloaded `racket-blabla.dmg`. Drag the entire `Racket v6.x.x` folder to `Applications` as instructed.
3. Add `racket` and `raco` to your `$PATH` so that they can be easily found.
  - Edit your `~/.bash_profile` (or `~/.zshrc` if you use zsh). Add the following line to the end of file:
    - `export PATH="/Applications/Racket v6.2.1/bin":$PATH`
4. Activate these changes. Open a terminal window — Mac comes with `Terminal.app` by default; it's not bad but [iTerm2](https://www.iterm2.com/) is a better and free alternative.
  - Run the following commands in your terminal:
    - `source ~/.bash_profile`
    - `echo "(require xrepl)" > ~/.racketrc` (Optional, but recommended. This will enable Racket's [XREPL](http://pkg-build.racket-lang.org/doc/xrepl/index.html) in the command line)
5. Try running `racket` in your terminal. You should be able to see a working REPL.

## 2. Get Emacs
There are quite a few Emacs versions for Mac. However, the most handy one I've found is Yamamoto Mitsuharu's port: a GitHub mirror of it can be found [here](https://github.com/railwaycat/mirror-emacs-mac). The following part will be a walk-through of installing it via [brew](http://brew.sh/) (a package manager for Mac that just works™). You may also grab the pre-built binary files from https://github.com/railwaycat/mirror-emacs-mac/releases, but updating it won't be as convenient as using brew.

1. Get brew.
  - Go to http://brew.sh/
  - Follow the instruction (just paste a script at a Terminal prompt)
2. Update brew.
  - `brew update`
3. Install Emacs via brew
  - `brew tap railwaycat/emacsmacport`
  - `brew install emacs-mac` (or `brew install emacs-mac --with-modern-icon` if you don't like the default icon)
  - `brew linkapps emacs-mac`
4. You should be able to find `Emacs.app` in your `Applications` folder.
5. To upgrade your Emacs, run `brew update && brew upgrade --all`

## 3. Configure Emacs
Configuring Emacs from scratch could take you a loooong time. For your convenience, I've uploaded a minimal `init.el` file that provides some basic functionalities (for racket-mode) and fixes.

1. Grab the file [`init.el`](./init.el) from this repo
2. Put it in the `~/.emacs.d/` folder
3. Restart your Emacs.app and wait for it to install packages (warnings are normal).
