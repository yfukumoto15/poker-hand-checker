RSpec.configure do |config|
    # Railsモデル以外のクラス（サービスクラスなど）を扱えるようにする
    config.include ActiveSupport::Testing::Assertions, type: :service
  end
  