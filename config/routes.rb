Rails.application.routes.draw do
    scope "id" do
        get ":name" => 'api#show'
        post ":name" => 'api#inc_or_create'
    end
end
