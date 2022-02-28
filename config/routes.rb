Rails.application.routes.draw do
  # namespace -> コントローラーをグルーピングし、またURLにもその情報を付与する
  namespace :api do
    namespace :v1 do
      # 特定のリソースに対するルーティングはresourcesを使う
      # resources :foods, だけだと、7つのHTTPメソッド作られるので注意
      resources :restaurants do
        resources :foods, only: %i[index]
      end
      resources :line_foods, only: %i[index create]
      # 'line_foods/replace' というPUTリクエスト -> line_foods_controller.rbのreplaceメソッド
      put 'line_foods/replace', to: 'line_foods#replace'
      resources :orders, only: %i[create]
    end
  end
end
