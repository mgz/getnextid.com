Rails.application.routes.draw do
    root to: 'counters#index'
    scope "counter" do
        get ':name/info' => 'counters#show', constraints: { name: /.+/ }
        get ":name" => 'api#show', constraints: { name: /.+/ }
        post ":name" => 'api#inc', constraints: { name: /.+/ }
    end
    resources :counters do
    end
    

end
