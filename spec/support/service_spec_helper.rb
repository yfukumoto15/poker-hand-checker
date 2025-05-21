# RSpecの設定
RSpec.configure do |config|
  # サービスクラスのテストでアサーションを使えるようにする
  config.include ActiveSupport::Testing::Assertions, type: :service
end
