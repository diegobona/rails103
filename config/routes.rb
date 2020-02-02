Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'groups#index'
  resources :groups do
    member do
      post :join
      post :quit
    end
    resources :posts do
    end
  end
  
 
  namespace :account do
    resources :groups
    resources :posts
  end
  
  #不用命名空间，下面这种自由的配置方式在仅需查看的场景下可以，如果还需要有编辑删除等操作，路由定义就比较麻烦
  # get 'groups/join/my', to: 'groups#showMyJoinedGroups'
  # get 'posts/my', to: 'posts#showMyPosts'
  
  
end

