#! /bin/bash

# Singularity 環境構築用のシェルスクリプト(Singularity v3.9.5)

# 依存関係のインストール
sudo apt update && sudo apt install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git

# Goのインストール(バージョンは適宜変更)
export VERSION=1.17.2 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

# Goの 環境設定
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    export GOPATH=${HOME}/go && \
    export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin


# リリースからSingularityCEをインストール(バージョンは適宜変更)
# export VERSION=3.10.0 && # adjust this as necessary \
#     wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz && \
#     tar -xzf singularity-ce-${VERSION}.tar.gz && \
#     cd singularity-ce-${VERSION}

# ソースからSinguralityをインストール
git clone https://github.com/sylabs/singularity.git && \
    cd singularity && \
    git checkout v3.9.5

# Singuralityをコンパイル
./mconfig && \
    make -C ./builddir && \
    sudo make -C ./builddir install

# bash補完
. /usr/local/etc/bash_completion.d/singularity

# singularityリポジトリを削除
rm -rf ../singularity/
