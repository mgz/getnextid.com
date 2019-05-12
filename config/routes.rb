Rails.application.routes.draw do
    root to: 'counters#index'
    scope "id" do
        get ":name" => 'api#show'
        post ":name" => 'api#inc_or_create'
    end
    resources :counters do
    
    end
end
