#!/bin/bash
#
# Install fresh with the following command:
#
#   bash -c "`curl -sL get.freshshell.com`"

set -e

mkdir -p ~/.fresh/source/freshshell

if [ -d ~/.fresh/source/freshshell/fresh ]; then
  cd ~/.fresh/source/freshshell/fresh
  git pull --rebase
  cd "$OLDPWD"
else
  git clone https://github.com/freshshell/fresh ~/.fresh/source/freshshell/fresh
fi

FRESH_LOCAL="${FRESH_LOCAL:-$HOME/.dotfiles}"
if [ -n "$FRESH_LOCAL_SOURCE" ] && ! [ -d "$FRESH_LOCAL" ]; then
  if ! [[ "$FRESH_LOCAL_SOURCE" == */* || "$FRESH_LOCAL_SOURCE" == *:* ]]; then
    echo 'FRESH_LOCAL_SOURCE must be either in user/repo format or a full Git URL.' >&2
    exit 1
  fi

  if echo "$FRESH_LOCAL_SOURCE" | grep -q :; then
    git clone "$FRESH_LOCAL_SOURCE" "$FRESH_LOCAL"
  else
    git clone "https://github.com/$FRESH_LOCAL_SOURCE.git" "$FRESH_LOCAL"
    git --git-dir="$FRESH_LOCAL/.git" remote set-url --push origin "git@github.com:$FRESH_LOCAL_SOURCE.git"
  fi
fi

if ! [ -e ~/.freshrc ]; then
  if [ -r "$FRESH_LOCAL/freshrc" ]; then
    ln -s "$FRESH_LOCAL/freshrc" ~/.freshrc
  else
    cat << 'EOF' > ~/.freshrc
FRESH_NO_BIN_CONFLICT_CHECK=true

# handles updating fresh
fresh freshshell/fresh bin/fresh --bin

# builds jasoncodes' aliases into ~/.fresh/build.sh
fresh jasoncodes/dotfiles shell/aliases/\*

# builds the shell/aliases/git.sh file into ~/.fresh/build/shell.sh
fresh twe4ked/dotfiles shell/aliases/git.sh

# links the config/ackrc file to ~/.ackrc
fresh twe4ked/dotfiles config/ackrc --file

# links the gemdiff file to ~/bin/gem-diff
fresh jasoncodes/dotfiles bin/gemdiff --bin=~/bin/gem-diff

# builds the aliases/github.sh file locked to the specified git ref
fresh twe4ked/dotfiles aliases/github.sh --ref=bea8134
fresh jasoncodes/dotfiles config/tmux.conf --file
fresh twe4ked/dotfiles config/tmux.conf --file
fresh foobacca/dotfiles tmux/clipboard --file=~/tmux.conf
fresh twe4ked/dotfiles 'vim/*' --file=~/.vimrc --marker='"'
fresh jasoncodes/dotfiles config/pryrc --file --marker
fresh tpope/vim-pathogen . --file=~/.vim/bundle/vim-pathogen/
fresh zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting.zsh --file=vendor/zsh-syntax-highlighting.zsh
fresh zsh-users/zsh-syntax-highlighting highlighters --file=vendor/highlighters/
fresh jasoncodes/dotfiles bin/sedmv --bin
fresh jasoncodes/dotfiles bin/gemdiff --bin=~/bin/gem-diff
fresh twe4ked/dotfiles shell/functions/hitch.sh
fresh nojhan/liquidprompt liquidprompt
fresh foobacca/dotfiles shell/aliases-dir
fresh foobacca/dotfiles shell/tmux
fresh rupa/z z.sh
fresh twe4ked/dotfiles shell/zsh/completion.zsh --file=~/.zshrc
fresh twe4ked/dotfiles shell/zsh/prompt.zsh --file=~/.zshrc
fresh twe4ked/dotfiles shell/zsh/zshrc --file
fresh sharat87/zsh-vim-mode zsh-vim-mode.plugin.zsh
fresh robbyrussell/oh-my-zsh lib/edit-command-line.zsh --ref=a38774c
fresh zsh-users/zsh-history-substring-search zsh-history-substring-search.zsh
fresh freshshell/fresh contrib/completion/fresh-completion.zsh --file=completion/_fresh
fresh twe4ked/dotfiles aliases/github.sh --ref=bea8134
fresh twe4ked/dotfiles shell/aliases/git.sh
fresh bobthecow/git-flow-completion git-flow-completion.zsh
fresh jasoncodes/dotfiles config/gitconfig --file
fresh jasoncodes/dotfiles shell/aliases/git.sh
fresh pengwynn/dotfiles bin/git-pr --bin
fresh jasoncodes/dotfiles config/ackrc --file
fresh jasoncodes/dotfiles config/inputrc --file
fresh foobacca/dotfiles tmux/ctrl-a --file=~/tmux.conf
fresh foobacca/dotfiles tmux/maximise-pane --file=~/tmux.conf
fresh foobacca/dotfiles tmux/save-buffer-history --file=~/tmux.conf
fresh foobacca/dotfiles tmux/statusbar --file=~/tmux.conf
fresh foobacca/dotfiles tmux/vi --file=~/tmux.conf
fresh foobacca/dotfiles tmux/misc-bindings --file=~/tmux.conf
fresh foobacca/dotfiles tmux/misc-settings --file=~/tmux.conf
fresh jasoncodes/dotfiles config/screenrc --file
fresh-options --bin
fresh twe4ked/catacomb bin/catacomb
fresh jasoncodes/dotfiles bin/\*
fresh jasoncodes/dotfiles bin/wemux/\*
fresh pengwynn/dotfiles bin/gxpr
fresh pengwynn/dotfiles bin/git-go
fresh pengwynn/dotfiles bin/+x
fresh defunkt/repl bin/repl
fresh hackling/morse bin/morse
fresh garybernhardt/selecta selecta
fresh garybernhardt/dotfiles bin/field
fresh garybernhardt/dotfiles bin/run-command-on-git-revisions
fresh pengwynn/dotfiles bin/git-pr
fresh pengwynn/dotfiles bin/mx
fresh sj26/git-buildkite git-buildkite
fresh-options
fresh jasoncodes/dotfiles shell/aliases/\*
fresh jasoncodes/dotfiles shell/editor.sh
fresh jasoncodes/dotfiles shell/config/filters.sh
fresh jasoncodes/dotfiles shell/config/pager.sh
fresh jasoncodes/dotfiles shell/config/heroku.sh
fresh jasoncodes/dotfiles shell/config/chruby.sh
fresh jasoncodes/dotfiles shell/config/tmux.sh
fresh jasoncodes/dotfiles shell/functions/realpath.sh
fresh markryall/dotfiles shell/aliases/dvcs.sh

# Vim
fresh-options --file=~/.vimrc --marker='"'
fresh jasoncodes/dotfiles vim/mappings/indent.vim
fresh jasoncodes/dotfiles vim/mappings/pasteboard.vim
fresh jasoncodes/dotfiles vim/mappings/whitespace.vim --filter=filter_vundle_lines
fresh jasoncodes/dotfiles vim/config/undo.vim
fresh jasoncodes/dotfiles vim/config/auto_mkdir.vim
fresh jasoncodes/dotfiles vim/config/search.vim
fresh jasoncodes/dotfiles vim/config/cursor.vim
fresh jasoncodes/dotfiles vim/config/bubbling.vim
fresh jasoncodes/dotfiles vim/functions.vim
fresh jasoncodes/dotfiles vim/plugins/ctrlp.vim --filter=filter_vundle_lines
fresh jasoncodes/dotfiles vim/plugins/markdown.vim --filter=filter_vundle_lines
fresh jasoncodes/dotfiles vim/plugins/ruby.vim --filter=filter_vundle_lines
fresh hackling/dotfiles vim/plugins/surround.vim --filter=filter_vundle_lines
fresh hackling/dotfiles vim/keybindings/filename-to-clipboard.vim
fresh nathanaelkane/dotfiles vim/plugins/easymotion.vim
fresh jasoncodes/dotfiles vim/config/completion.vim
fresh-options
fresh vim/gvimrc --file
fresh vim/colors --file=~/.vim/colors/

# Config
fresh-options --file
fresh config/\*
fresh jasoncodes/dotfiles config/inputrc
fresh jasoncodes/dotfiles config/tmux.conf
fresh jasoncodes/dotfiles config/psqlrc
fresh-options
fresh config/ranger/rc.conf --file=~/.config/ranger/rc.conf
fresh henrik/dotfiles rubyrc --file=~/.pryrc --filter='cat; echo include RubyRC'
fresh nathanaelkane/dotfiles config/tmux/ctrlg.conf --file=~/.tmux.conf

# Zsh
fresh-options --file=~/.zshrc --marker
fresh shell/zsh/completion.zsh
fresh shell/zsh/prompt.zsh
fresh shell/zsh/title.zsh
fresh shell/zsh/aliases.zsh
fresh shell/zsh/zshrc
fresh shell/zsh/keybindings.zsh
fresh shell/zsh/selecta.zsh

# this loads the shell files and needs to be at the bottom of the zshrc for
# compdef be availiable
fresh freshshell/fresh contrib/source-build.sh
fresh rupa/z z.sh
fresh robbyrussell/oh-my-zsh lib/edit-command-line.zsh --ref=a38774c
fresh robbyrussell/oh-my-zsh plugins/git-flow/git-flow.plugin.zsh --ref=df30eae
fresh bjeanes/dot-files shells/zsh/lib/completion-waiting-dots.zsh

# de-duplicate PATH
fresh akatov/dotfiles zshrc/dedup-path --ref=55e80fe

fresh rimraf/k k.sh
fresh-options

fresh zsh-users/zsh-completions src/_ack --file=completion/_ack
fresh zsh-users/zsh-completions src/_heroku --file=completion/_heroku
fresh robbyrussell/oh-my-zsh plugins/brew/_brew --file=completion/_brew --ref=55f09f8
fresh shell/zsh/completions/_gh --file=completion/_gh
fresh thoughtbot/dotfiles zsh/completion/_ag --file=completion/_ag

fresh zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting.zsh --file=vendor/zsh-syntax-highlighting.zsh
fresh zsh-users/zsh-syntax-highlighting highlighters/main/main-highlighter.zsh --file=vendor/highlighters/main/main-highlighter.zsh
fresh zsh-users/zsh-syntax-highlighting highlighters/brackets/brackets-highlighter.zsh --file=vendor/highlighters/brackets/brackets-highlighter.zsh
fresh shell/zsh/zsh-syntax-highlighting.zsh --file=~/.zshrc

EOF
  fi
fi

~/.fresh/source/freshshell/fresh/bin/fresh

cat <<-MESSAGE

  __               _
 / _|             | |
| |_ _ __ ___  ___| |__
|  _| '__/ _ \/ __| '_ \\
| | | | |  __/\__ \ | | |
|_| |_|  \___||___/_| |_|
http://freshshell.com/

MESSAGE
if ! [ -L ~/.freshrc ]; then
  cat <<-MESSAGE
You're all ready to get fresh!

Add \`$(echo $'\033[1;32msource ~/.fresh/build/shell.sh\033[0m')\` to your shell config.

Open a new shell, run \`fresh edit\` to start editing your .freshrc file
then run \`fresh\` to update your shell.

MESSAGE
fi
