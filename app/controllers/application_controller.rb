class ApplicationController < ActionController::API
  before_action :fake_load
  # 全てのAPI controllerの処理のbefore_actionとしてfake_loadを実行する
  def fake_load
    sleep(1)
  end
end
