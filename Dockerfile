ARG COQ_IMAGE=coqorg/coq:8.17.1-ocaml-4.14.1-flambda
FROM ${COQ_IMAGE}

RUN opam clean -y -a -c -s --logs
RUN eval $(opam env)
RUN sudo apt-get update

# Install Fstar
ENV FSTAR_DOWNLOAD_URL="https://github.com/FStarLang/FStar/releases/download/v2023.09.03/fstar_2023.09.03_Linux_x86_64.tar.gz"
RUN curl -L $FSTAR_DOWNLOAD_URL -o fstar_linux_x86_64.tar.gz && \
    tar -xzvf fstar_linux_x86_64.tar.gz && \
    rm fstar_linux_x86_64.tar.gz && \
    mv fstar "$HOME/.fstar"
ENV PATH="$HOME/.fstar/bin:${PATH}"

# Install Haskell
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org \
    | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
        BOOTSTRAP_HASKELL_GHC_VERSION=latest \
        BOOTSTRAP_HASKELL_CABAL_VERSION=latest \
        BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
        BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
        BOOTSTRAP_HASKELL_ADJUST_BASHRC=P \
        BOOTSTRAP_HASKELL_VERBOSE=1 \
        sh && \
    echo ". $HOME/.ghcup/env" >> "$HOME/.bashrc" 

# Install Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Koka
RUN curl -sSL https://github.com/koka-lang/koka/releases/latest/download/install.sh | sh

# Install Node.js and Typescript
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
ENV NVM_DIR="/home/coq/.nvm"
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install node && \
    nvm use node && \
    npm install -g typescript

