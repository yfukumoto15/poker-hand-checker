# Railsの起動設定を読み込む
require_relative "boot"

# Railsの全機能を読み込む
require "rails/all"

# Gemfileで指定されたGemを読み込む
Bundler.require(*Rails.groups)

module Pokergame
  class Application < Rails::Application
    # APIフォルダを自動読み込み対象に追加
    config.autoload_paths += %W(#{config.root}/app/api)

    # Rails 8.0の初期設定を適用
    config.load_defaults 8.0

    # ここにアプリケーション全体の設定を記述
    # 例:
    # config.time_zone = "Tokyo"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
