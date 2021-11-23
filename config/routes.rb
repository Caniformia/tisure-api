Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :subjects, shallow: true do
    resources :chapters do
      resources :questions do
        resources :choices do
          get 'stats'
        end
        resources :comments
        resources :tags, except: :show
        post 'attach_image'
        get 'records'
        get 'stats'
      end
    end
  end
  resources :records
  get 'stats', to: 'records#stats'

  resources :question_list_items
  resources :question_lists
  get 'question_lists/:id/questions', to: 'question_lists#show_questions'
  get 'tags/:name', to: 'tags#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
