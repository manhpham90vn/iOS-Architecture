#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-cmd.sh
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/ruby-setup.sh

if ! $RBENV_CMD --version &> /dev/null
then
    source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh $RBENV_CMD

    case $SHELL in
    */bash)
        SHELL_RUN_CMD_PATH="$HOME/.bashrc"
    ;;
    */zsh)
        SHELL_RUN_CMD_PATH="$HOME/.zshrc"
    ;;
    */fish)
        SHELL_RUN_CMD_PATH="$HOME/.config/fish/config.fish"
    ;;
    esac

    if ! ( grep -q "${RBENV_CONFIG_EXPORT_PATH}" "${SHELL_RUN_CMD_PATH}" ); then
        echo $RBENV_CONFIG_EXPORT_PATH >> $SHELL_RUN_CMD_PATH
    fi
    if ! ( grep -q "${RBENV_CONFIG_INIT}" "${SHELL_RUN_CMD_PATH}" ); then
        echo $RBENV_CONFIG_INIT >> $SHELL_RUN_CMD_PATH
    fi

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if ! $RUBY_CMD --version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install $RUBY_CMD $PROJECT_RUBY_VERSION"

    $RBENV_CMD install -s $PROJECT_RUBY_VERSION
    $RBENV_CMD global $PROJECT_RUBY_VERSION
fi

if ! $BUNDLER_CMD --version &> /dev/null
then
    $GEM_CMD install bundler:$BUNDLER_VERSION
fi

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Install gem use $BUNDLER_CMD"

$BUNDLER_CMD config --local path $BUNDLER_PATH
$BUNDLER_CMD config --local without 'documentation'
$BUNDLER_CMD config --local jobs 4
$BUNDLER_CMD config --local retry 3

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done install gem use $BUNDLER_CMD"