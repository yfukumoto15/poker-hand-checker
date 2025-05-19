# GemfileはRailsアプリケーションで使用する外部ライブラリ（Gem）を管理するファイルです。
# BundlerというツールがGemfileを参照し、指定されたGemをインストール・管理します。

# GemをダウンロードするためのソースURLを指定
source "https://rubygems.org"

# Railsフレームワークのバージョンを指定
# ~> 8.0.2 は、8.0.2以上8.1未満の最新版を意味します。
gem "rails", "~> 8.0.2"

# 最新のアセットパイプラインを提供するGem
# Rails 7以降で使われるPropshaftを利用し、CSSやJavaScriptを管理します。
gem "propshaft"

# データベースとしてSQLite3を使用
# 開発・テスト環境では手軽なデータベースとして利用されます。
gem "sqlite3", ">= 2.1"

# WebサーバーとしてPumaを使用
# マルチスレッド対応で、高速かつ軽量なWebサーバーです。
gem "puma", ">= 5.0"

# JavaScriptモジュール管理を行うためのGem
# モダンなJavaScript管理をサポートし、ESM（ECMAScriptモジュール）に対応しています。
gem "importmap-rails"

# API作成を容易にするためのGrapeフレームワーク
# RESTfulなAPIを簡単に作成・管理できます。
gem "grape"

# SPA（シングルページアプリケーション）を支援するためのGem
# Turboを使ってページ遷移を高速化し、ユーザー体験を向上させます。
gem "turbo-rails"

# シンプルなJavaScriptフレームワークで、UI操作を支援します。
# Turboと組み合わせて動的なWebアプリケーションを作成可能です。
gem "stimulus-rails"

# JSON形式のレスポンスを生成するためのGem
# APIレスポンスをJSON形式で返す際に便利です。
gem "jbuilder"

# Windows環境での時刻管理に使用されるGem
# tzinfo-dataはタイムゾーン情報を扱うために使います。
gem "tzinfo-data", platforms: %i[mingw jruby]

# キャッシュ管理に使われるGem
gem "solid_cache"
# ジョブキュー管理を行うGem
gem "solid_queue"
# Webソケットを使ったリアルタイム通信を管理するGem
gem "solid_cable"

# アプリケーションの起動を高速化するためのGem
# キャッシュを利用して、起動時間を短縮します。
gem "bootsnap", require: false

# Dockerコンテナでのデプロイを支援するGem
# Kamalはシンプルなデプロイツールです。
gem "kamal", require: false

# PumaサーバーのHTTPキャッシュや圧縮をサポートするGem
# 高速なレスポンスを提供するために使用します。
gem "thruster", require: false

# 開発環境およびテスト環境で利用するGemをグループ化
group :development, :test do
  # デバッグ用のGem
  # プログラムの途中で値を確認したり、エラーを調査する際に使います。
  gem "debug", platforms: %i[mri mingw], require: "debug/prelude"

  # コードのセキュリティチェックを自動化するGem
  # 脆弱性を検出し、安全なコードに改善するために使います。
  gem "brakeman", require: false

  # コードスタイルを自動チェックするGem
  # Rubyコードをきれいに保つためのツールです。
  gem "rubocop-rails-omakase", require: false

  # RSpecテストフレームワーク
  # Railsアプリの単体テストや統合テストに利用されます。
  gem "rspec-rails", "~> 8.0"
end

# 開発環境専用のGemをグループ化
group :development do
  # Webコンソールを表示するためのGem
  # エラー発生時にインタラクティブにデバッグできる便利なツールです。
  gem "web-console"
end

# テスト環境専用のGemをグループ化
group :test do
  # E2E（エンドツーエンド）テストをサポートするGem
  # 実際のブラウザ操作を自動化し、ユーザー操作を検証します。
  gem "capybara"
  gem "selenium-webdriver"
end
