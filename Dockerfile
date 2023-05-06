from archlinux

# update
RUN pacman -Syu --noconfirm

# install basic tools
RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    vim \
    wget \
    curl \
    zsh \
    tmux \
    neovim 


ARG UNAME
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o $UNAME && \
    useradd -m -u $UID -g $GID -o -s /bin/zsh $UNAME && \
    echo "$UNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$UNAME

RUN echo "root:123123" | chpasswd
RUN echo "$UNAME:123123" | chpasswd 

USER $UNAME

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /home/$UNAME/rustup.sh
RUN chmod +x /home/$UNAME/rustup.sh
RUN bash /home/$UNAME/rustup.sh -y
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

RUN /home/$UNAME/.cargo/bin/cargo search

# Install Yay
RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
    cd /tmp/yay && \
    makepkg -si --noconfirm && \
    cd - && \
    rm -rf /tmp/yay

# Install Python 3.8 using Yay
RUN yay -S --noconfirm python38

RUN . "$HOME/.nvm/nvm.sh" \
    && nvm install 18 \
    && nvm use 18 \
    && nvm alias default 18

USER root

RUN pacman -Syu --noconfirm go
RUN pacman -Syu --noconfirm ripgrep

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER $UNAME

ENTRYPOINT ["/entrypoint.sh"]

