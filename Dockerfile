# コピペでOK, app_nameもそのままでOK
# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.6

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
# 最新のyarnを取得
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn

# 作業ディレクトリの作成、設定
RUN mkdir /dog_find_partner
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /dog_find_partner
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
