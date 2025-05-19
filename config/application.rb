# Railsアプリケーションのブート（起動）プロセスに関連する設定ファイルを読み込む
require_relative "boot"

# Rails全体を使うために、すべてのフレームワークを読み込む
# "rails/all" は、Railsの各種ライブラリ（ActiveRecord, ActionControllerなど）を一括でインポートする
require "rails/all"

# GemfileにリストされているGemをすべて読み込む
# Bundler.requireは、指定されたグループ（:test, :development, :production）ごとにGemをロードする
Bundler.require(*Rails.groups)

# モジュールPokergameを定義し、その中でRailsアプリケーションとしてのクラスを定義
module Pokergame
  # Railsアプリケーションクラスを継承して、アプリケーションの設定を管理
  class Application < Rails::Application
    # 自動読み込みパス（autoload_paths）にAPIフォルダを追加
    # config.root はアプリケーションのルートパス（プロジェクトの最上位ディレクトリ）を指す
    # "app/api" フォルダを自動的に読み込むパスとして追加することで、API関連のファイルを自動ロードする
    config.autoload_paths += %W(#{config.root}/app/api)

    # Rails 8.0のデフォルト設定を読み込む
    # これにより、最新バージョンで推奨される設定が適用される
    config.load_defaults 8.0

    # アプリケーションの全体設定をここに記述する
    # "engines" や "railties" とは、Railsアプリケーションの拡張モジュールやプラグインのこと
    # 基本的にはアプリケーション全体に適用される設定を書く場所
    #
    # 環境ごとに異なる設定（開発、テスト、本番）を指定するためには
    # "config/environments" フォルダ内の各ファイル（development.rbなど）で指定する
    #
    # タイムゾーンの設定（コメントアウトされているが、必要に応じて有効化）
    # config.time_zone = "Central Time (US & Canada)"
    #
    # 追加で自動読み込みするパスを指定することも可能
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
