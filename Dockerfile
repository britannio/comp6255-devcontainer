ARG COQ_IMAGE=coqorg/coq:8.17.1-ocaml-4.14.1-flambda
FROM ${COQ_IMAGE}

RUN opam clean -y -a -c -s --logs
RUN eval $(opam env)

# Install Fstar
RUN sudo apt-get update && \
    sudo apt-get install --no-install-recommends -y jq && \
    fstar_latest=$(curl -s https://api.github.com/repos/FStarLang/FStar/releases/latest) && \
    fstar_download_url=$(echo "$fstar_latest" | jq -r '.assets[] | select(.name | test("Linux_x86_64.tar.gz")) | .browser_download_url') && \
    curl -L $fstar_download_url -o fstar_latest_linux_x86_64.tar.gz && \
    tar -xzvf fstar_latest_linux_x86_64.tar.gz
ENV PATH="/home/coq/fstar/bin:${PATH}"

# Install Haskell
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 BOOTSTRAP_HASKELL_GHC_VERSION=latest BOOTSTRAP_HASKELL_CABAL_VERSION=latest BOOTSTRAP_HASKELL_INSTALL_STACK=1 BOOTSTRAP_HASKELL_INSTALL_HLS=1 BOOTSTRAP_HASKELL_ADJUST_BASHRC=P BOOTSTRAP_HASKELL_VERBOSE=1 sh
RUN cat ~/.ghcup/env >> ~/.bashrc

# Install Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
