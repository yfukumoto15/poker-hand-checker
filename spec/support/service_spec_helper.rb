RSpec.configure do |config|
    # RSpec（アールスペック）とは、Rubyで書かれたテストフレームワークのことです。
    # テストフレームワークとは、ソフトウェアの挙動が正しいかどうかを検証するためのツールです。
    # RSpec.configureブロック内では、RSpecの設定を行うことができます。
  
    # Railsモデル以外のクラス（サービスクラスなど）をテストできるように設定します。
    # Railsアプリケーションでは、モデルやコントローラだけでなく、サービスクラスなど独自のクラスを使うことがあります。
    # サービスクラス：アプリケーション内で特定の処理をまとめて行う役割を持つクラスです。
    # RSpecでサービスクラスをテストするために、以下のモジュールを含めます。
  
    # ActiveSupport::Testing::Assertions とは
    # ActiveSupportは、Railsに含まれる便利なユーティリティをまとめたモジュールです。
    # Testing::Assertionsは、その中でもテストで使われる「アサーション」を提供します。
    # アサーション（Assertion）：テストで使われる「主張」や「断言」のことです。
    # たとえば「値が正しいかどうか」を確認するときに使います。
    
    # config.includeは、指定したモジュールをRSpecのテスト環境に組み込むためのメソッドです。
    # type: :service という部分は、特定のタイプ（ここではサービスクラス）に対してのみ適用される設定を意味します。
    config.include ActiveSupport::Testing::Assertions, type: :service
  end
  