#!/bin/zsh
#将原有gopath路径下的文件移动到volume映射的gopath路径中，并重新设置zsh中的gopath路径
mv -i $HOME/gopath $HOME/work
sed -ri '/^export GOPATH/s/^.*$/export GOPATH=$HOME\/work\/gopath/g' $HOME/.zshrc
. $HOME/.zshrc
#cp $HOME/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py $HOME
