FROM golang:1.12.1

ARG USERNAME=dev
ARG GROUPNAME=dev
ARG UID=1000
ARG GID=1000

RUN \
  # パッケージインストール
  apt-get update -y -qq && apt-get install -y -qq --no-install-recommends \
  apt-utils \
  nano \
  sudo \
  ; \
  \
  # キャッシュ削除
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* \
  ; \
  \
  # 開発ユーザ作成
  groupadd -g $GID $GROUPNAME && \
  useradd -m -s /bin/bash -u $UID -g $GID $USERNAME \
  ; \
  \
  # 開発ユーザに sudo 権限を付与
  echo "" >> /etc/sudoers ; \
  echo "# Don't require password for sudo command for dev user" >> /etc/sudoers ; \
  echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME

