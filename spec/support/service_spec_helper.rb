# =============================
# RSpecの設定ファイル
# サービスクラスのテストで便利なアサーション（検証メソッド）を使えるようにする
# =============================

RSpec.configure do |config|
  # サービスクラスのテストでActiveSupportのアサーション（検証メソッド）を使えるようにする
  config.include ActiveSupport::Testing::Assertions, type: :service
end
