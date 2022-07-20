Rails.application.routes.draw do
  root "bank#index"

  resources :accounts
  resource :session, only: [:new, :create, :destroy]

  get "signup" => "accounts#new"
  get "signin" => "sessions#new"

  get "deposit" => "transactions#deposit_new"
  post "deposit" => "transactions#deposit_create"

  get "withdrawal" => "transactions#withdrawal_new"
  post "withdrawal" => "transactions#withdrawal_create"

  get "transference" => "transactions#transference_new"
  post "transference" => "transactions#transference_create"

  get "balance" => "transactions#check_balance"

  get "statement" => "transactions#statement_new"
  get "statement_receipt" => "transactions#statement_receipt"

  get "transaction/:id" => "transactions#receipt", as: "transaction_receipt"
end
