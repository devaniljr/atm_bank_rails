require "rails_helper"
RSpec.feature "User make a deposit" do
  scenario "user not registered makes a valid deposit" do
    transaction_destination = "devaniljunior@live.com"
    transaction_amount = 200

    visit root_path

    click_on "Faça um depósito"
    fill_in "transaction_destination", with: transaction_destination
    fill_in "transaction_amount", with: transaction_amount
    click_on "Fazer o depósito"

    expect(page).to have_content("Depósito realizado com sucesso")
  end
end
