#!/bin/bash
set -e

# ensure this repository is in PATH
REPO_PATH="$(cd $(dirname "$0"); pwd)"
if [[ ! "$PATH" == *$REPO_PATH* ]]; then
    echo -e "\nexport PATH=\"\$PATH:$REPO_PATH\"" >> ~/.bashrc;
fi

# ensure bash prompt shows smart git status
if [[ ! "$PS1" == *__git_ps1_recursive* ]]; then
    if [[ "$PS1" == *__git_ps1* ]]; then
        # add a hook for replacing regular git prompt with recursive one
        echo 'export PS1=$(echo "$PS1" | sed "s/__git_ps1_recursive/__git_ps1/")' >> ~/.bashrc
    else
        # no git status in prompt at all - override prompt
        echo 'export PS1="\[\e[94m\]\u@\h \[\e[96m\]\w\[\e[0m\]\$(__git_ps1_recursive)\n\\$ "' >> ~/.bashrc
    fi
fi

# configure alias for smart status
git config --global alias.st smart-status

echo "Installation complete. Reload your terminal session to see effects."
