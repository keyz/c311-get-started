# c311-get-started

This document will serve as an (opinionated) guide for setting up Racket and Emacs on a Mac OS X. If you are on a Windows machine, [@jasonhemann](https://github.com/jasonhemann)'s [note](https://cgi.soic.indiana.edu/~c311/lib/exe/fetch.php?media=windows.pdf) should help.

## 1. Get Racket
1. Download the latest version of Racket from http://download.racket-lang.org/. Make sure you choose "Racket" as the distribution; the platform should probably just be "Mac OS X (Intel 64-bit)".
2. Open the downloaded `racket-blabla.dmg`. Drag the entire `Racket v6.x.x` folder to `Applications` as instructed.
3. Add `racket` and `raco` to your `$PATH` so that they can be easily found.
   - Edit your `~/.bash_profile` (or `~/.zshrc` if you use zsh). Run the following line in your terminal:
   - `echo 'export PATH="/Applications/Racket v6.3/bin":$PATH' >> ~/.bash_profile`
     - As of August 2015, the latest version of Racket is v6.3; if you download a newer version of Racket, make sure you to edit the version above.
4. Activate these changes. Open a terminal window — Mac comes with `Terminal.app` by default; it's not bad but [iTerm2](https://www.iterm2.com/) is a better and free alternative.
   - Run the following commands in your terminal:
   - `source ~/.bash_profile`
   - `echo "(require xrepl)" > ~/.racketrc` (Optional, but recommended. This will enable Racket's [XREPL](http://pkg-build.racket-lang.org/doc/xrepl/index.html) in the command line)
5. Try running `racket` in your terminal. You should be able to see a working REPL.

## 2. Get Emacs
There are quite a few Emacs versions for Mac. However, the most handy one I've found is Yamamoto Mitsuharu's port: a GitHub mirror of it can be found [here](https://github.com/railwaycat/mirror-emacs-mac). The following part will be a walk-through of installing it via [brew](http://brew.sh/) (a package manager for Mac that just works™). You may also grab the pre-built binary files from https://github.com/railwaycat/mirror-emacs-mac/releases, but updating it won't be as convenient as using brew.

1. Get brew.
  - Go to http://brew.sh/
  - Follow the instruction (paste the one-liner at a terminal prompt).
2. Update brew.
  - `brew update`
3. Install Emacs via brew.
  - `brew tap railwaycat/emacsmacport`
  - `brew install emacs-mac` (or `brew install emacs-mac --with-modern-icon` if you don't like the default icon)
  - `brew linkapps emacs-mac`
4. You should be able to find `Emacs.app` in your `Applications` folder.
5. If you want to be able to launch **GUI** Emacs via the terminal, add `alias e='open -a /Applications/Emacs.app'` to your `.bash_profile`.
5. In the future, to upgrade your Emacs, run `brew update && brew upgrade emacs-mac`.

## 3. Configure Emacs
Configuring Emacs from scratch could take you a loooong time. For your convenience, we've uploaded a minimal `init.el` file that provides some basic functionalities (for `racket-mode`) and fixes.

1. Grab the file [`init.el`](./init.el) from this repo
2. Put it in the `~/.emacs.d/` folder
3. Restart your Emacs.app and wait for it to install packages (warnings are normal).

### What's included in this `init.el`?
- Automatic package installation, including:
  - `racket-mode` for all the greatness.
    - We rebind the `racket-run` command to `meta-enter` (`option-enter`). This is basically equivalent with DrRacket's `Run` button. If you don't like the keybinding, just modify it in `init.el`.
  - `helm` cuz nobody can memorize all the emacs functions.
  - `company` for auto completion.
  - `rainbow-delimiters` so we won't need to get LASIK.
  - `paredit` is included but disabled by default.
    - We highly recommend activating paredit for Scheme/Racket/Lisp modes, but we understand that it could take a while to get used to it.
    - Please read http://danmidwood.com/content/2014/11/21/animated-paredit.html first; when you are ready, change the line `(setq paredit-enabled nil)` to `(setq paredit-enabled t)` in `init.el` to activate paredit.
- Fixes
  - All the temporary files will be placed under `~/.emacs.d/bkup` so you won't see annoying `bla~` files in your working folder again.
  - The Mac `option` key becomes `meta`.
  - Perserve some OS X default system shortcuts in Emacs. To name a few:
    - `Command-a` = "Select All"
    - `Command-x` = "Cut", `Command-c` = "Copy", and `Command-v` = "Paste"
    - `Command-s` = "Save"
    - `Command-z` = "Undo"
  - `recentf-mode`: use `C-x C-r` to access a list of recently edited files.
  - Emacs grabs the `$PATH` variable from your shell.

That's it! Now you when you open a `.rkt` file, `racket-mode` will start working. The shortcut `option-enter` acts like DrRacket's `Run` button — make some changes, press `option-enter`, and you'll see some new stuff in the REPL.

## Others (a.k.a. I wish we could write more)
Customizing Emacs is beyond the scope of this guide. You'll find tons of information on http://emacswiki.org/ and stackoverflow. http://emacsrocks.com/ also has some good staff to watch.

Feel free to modify the `init.el` file (it's fun!). For more questions, please open a GitHub issue here: https://github.com/keyanzhang/c311-get-started/issues. If you find a better way to do things, pull requests are more than welcome!

## License
MIT
