class Transaction < ApplicationRecord
  belongs_to :account, optional: true

  validates :type_of_transaction, presence: true
  validates :amount, presence: true

  def self.transference_tax(value, date)
    tax = nil

    if date.monday? || date.tuesday? || date.wednesday? || date.thursday? || date.friday?
      if date.hour >= 9 && date.hour < 18
        tax = 5.0
      else
        tax = 7.0
      end
    else
      tax = 7.0
    end

    if value >= 1000.0
      return tax += 10
    else
      return tax
    end
  end
end
