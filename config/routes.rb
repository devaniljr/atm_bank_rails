Rails.application.routes.draw do
  root "bank#index"

  resources :accounts
  resource :session, only: [:new, :create, :destroy]

  get "signup" => "accounts#new"
  get "signin" => "sessions#new"

  get "deposit" => "deposit#new"
  post "deposit" => "deposit#create"

  get "withdrawal" => "withdrawal#new"
  post "withdrawal" => "withdrawal#create"

  get "transference" => "transference#new"
  post "transference" => "transference#create"

  get "balance" => "transactions#check_balance"

  get "statement" => "statement#new"
  get "statement_receipt" => "statement#receipt"

  get "transaction/:id" => "transactions#receipt", as: "transaction_receipt"
end
