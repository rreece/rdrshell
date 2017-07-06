#!/bin/bash
echo "cp dotfiles/.* ../"
cp dotfiles/.* ../
echo "cp -r dotfiles/.vim ../"
cp -r dotfiles/.vim ../

echo "You may want to copy additional scripts from the plugins into the"
echo "init directory to use them or copy your own there."

