Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :subjects, shallow: true do
    get 'progress', to: 'progresses#show'
    match 'progress', to: 'progresses#update', via: [:patch, :put]
    resources :chapters, except: :index do
      resources :questions, except: :index do
        resources :choices, except: [:index, :show] do
          get 'stats'
        end
        resources :comments, except: :index
        resources :tags, except: [:show, :update]
        post 'attach_image'
        get 'last_record'
        get 'stats'
      end
    end
  end
  get 'tags/:name', to: 'tags#show'

  resources :records, only: :create
  get 'records/stats', to: 'records#stats'
  get 'records/mistakes', to: 'records#mistakes'

  resources :question_list_items, only: [:create, :destroy]
  get 'question_lists/share/:link', to: 'question_lists#show_share'
  get 'question_lists/:id/reset_link', to: 'question_lists#reset_link'
  resources :question_lists

  resources :users, only: :show
  get 'user', to: 'users#show_current'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
