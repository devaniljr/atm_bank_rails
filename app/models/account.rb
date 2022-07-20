class Account < ApplicationRecord
  has_many :transactions

  has_secure_password

  attribute :balance, :decimal, default: 0.0

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
end
