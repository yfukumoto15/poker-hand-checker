# このファイルは、'rails generate rspec:install' を実行した際に 
# 'spec/' ディレクトリにコピーされる設定ファイルです。

# RSpecの基本設定ファイルを読み込む
require 'spec_helper'

# Railsの環境変数を設定します。
# 'RAILS_ENV' が未設定なら 'test' 環境をデフォルトにします。
ENV['RAILS_ENV'] ||= 'test'

# Railsアプリケーションの環境設定ファイルを読み込みます。
require_relative '../config/environment'

# 安全性チェック: 万が一、テスト環境ではなく本番環境で実行しようとした場合、
# データベースを守るためにテストを中断します。
abort("The Rails environment is running in production mode!") if Rails.env.production?

# RSpecをRailsプロジェクトで使うための設定を読み込みます。
require 'rspec/rails'

# 追加のrequireはここより下に書きます。
# Railsが完全に読み込まれてから必要なものを追加します。

# サポートファイルの自動読み込み設定
# 'spec/support' ディレクトリ以下のすべての '.rb' ファイルを読み込みます。
# 'sort' メソッドで順序を整え、 'require' で各ファイルをロードします。
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# ここからはテストに関する設定です。

# 'spec/support' 以下のファイルをすべて読み込みますが、
# '_spec.rb' で終わるファイルはテストとしても実行されるため、二重実行を避ける必要があります。
# '_spec.rb' を含むファイルは、サポート用ではなくテスト用として個別に記述することを推奨します。

# マイグレーションのチェックと適用を実施
# テスト実行前に保留中のマイグレーションがあるかを確認し、エラーが出たら実行を停止します。
begin
  # マイグレーションの整合性をチェックする設定（コメントアウトされている）
  # ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  # エラー内容を出力し、ステータスコード1で終了します。
  puts e.to_s.strip
  exit 1
end

# RSpecの設定を開始します。
RSpec.configure do |config|
  # ActiveRecordのフィクスチャを使う場合の設定（デフォルトではコメントアウト）
  # フィクスチャとは：テストデータを定義しておき、テスト実行時に自動で使用できる仕組み
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # トランザクションフィクスチャの使用を有効にします（コメントアウトされている）
  # テスト中にデータベースのロールバックを行い、テストが終了したらデータを元に戻すためのもの
  # config.use_transactional_fixtures = true

  # ActiveRecordを完全に無効化したい場合の設定（コメントアウトされている）
  # config.use_active_record = false

  # RSpec Railsはファイルのパスに基づいてテストの種類を自動判定します。
  # 例： 'spec/controllers' フォルダ内なら 'type: :controller' として扱われる
  # これを有効にしておくことで、テストファイルの書き方が簡単になります。
  config.infer_spec_type_from_file_location!

  # バックトレース（エラー発生時の呼び出し履歴）からRailsの内部コードを除外します。
  # エラーの原因をより分かりやすく表示するための工夫です。
  config.filter_rails_from_backtrace!

  # 任意のGemもバックトレースから除外できます。
  # 例: config.filter_gems_from_backtrace("gem name")

  # ActiveRecordを使わない場合に無効化する設定
  config.use_active_record = false
end
