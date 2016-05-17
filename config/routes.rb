Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'tokens',  to: 'payments#tokens'
      post 'charges', to: 'payments#charges'
    end
  end

end
