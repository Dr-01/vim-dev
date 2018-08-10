FROM ubuntu

WORKDIR /root

#去除警告 恢复原有包
RUN echo exit 0 > /usr/sbin/policy-rc.d
RUN apt-get update && (echo y | DEBIAN_FRONTEND=noninteractive sh -x /usr/local/sbin/unminimize)

#安装依赖库
RUN apt-get update && apt-get install -y \
    zsh  \
    curl \
    git  \
    python-dev \
    python3-dev\
    net-tools  \
    cmake \
    g++   \
    clang \
    golang\
    global\
    ack   \
    automake   \
    vim  \
    openssh-server

RUN git clone https://github.com/universal-ctags/ctags.git && \
    cd ctags && ./autogen.sh && ./configure && \
    make && make install && cd - && rm -fr ctags

#vim
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY .vimrc /root/
#先安装vim-go插件,防止后续安装GoInstallBinaries时,因为ShowPair插件在首次启动时创建doc目录(enter to continue)而出错
ENV GOPATH=/root/gopath
RUN vim +'PlugInstall vim-go' +qall
RUN vim +'silent :GoInstallBinaries' +qall

ADD YouCompleteMe.tar /root/.vim/plugged/
RUN vim +PlugInstall +qall
#YCM compile
RUN  cd /root/.vim/plugged/YouCompleteMe && \
    ./install.py --clang-completer --go-completer --system-libclang

#后续需要的文件
#COPY .ycm_extra_conf.py /root/

#openssh 
#RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
#RUN sed -ri 's/AcceptEnv LANG LC_*/#AcceptEnv LANG LC_*/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
EXPOSE 22

#zsh config
#ssh登录的时候会清空ENV中的环境变量
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
RUN echo 'export LC_ALL=C.UTF-8\nexport LANG=C.UTF-8\nexport SHELL=zsh\nexport TERM=xterm-256color\n/bin/zsh' >> .bashrc
RUN curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true && \
    git clone --recursive git://github.com/joel-porquet/zsh-dircolors-solarized /root/.oh-my-zsh/custom/plugins/zsh-dircolors-solarized
COPY .zshrc /root/
COPY .zsh-dircolors.config /root/
COPY workready.sh /root/
RUN cp /root/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py /root

#当vim配置的改动不是插件部分时 减少重新安装插件的耗时
#COPY vimrc0810 /root/.vimrc

#配置启动的环境变量
ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#考虑直接ssh启动
#ENTRYPOINT service ssh restart && /bin/zsh
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
