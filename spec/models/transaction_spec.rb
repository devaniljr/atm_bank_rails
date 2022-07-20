require 'rails_helper'

RSpec.describe Transaction, :type => :model do
  subject {
    described_class.new(type_of_transaction: "Deposit",
                        amount: 50,
                        destination: "gustavo@gmail.com",
                        account_id: 2)
  }

  describe "Validations" do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without the type_of_transaction" do
      subject.type_of_transaction = nil

      expect(subject).to be_invalid
    end

    it "is not valid without the amount" do
      subject.amount = nil

      expect(subject).to be_invalid
    end

      it "is not valid without the amount" do
      subject.amount = nil

      expect(subject).to be_invalid
    end
  end

  describe "Transference Tax" do
    it "it is R$ 5 from monday to friday at 9h to 18h" do
      data = Time.new(2022,7,19,15,00,00)

      expect(described_class.transference_tax(500, data)).to eql(5.0)
    end

    it "it is R$ 7 if its out of the hours determined above" do
      data = Time.new(2022,7,19,18,10,00)

      expect(described_class.transference_tax(500, data)).to eql(7.0)
    end

    it "it have a R$ 10 plus tax if its more than R$ 1000" do
      data = Time.new(2022,7,19,19,10,00)

      expect(described_class.transference_tax(1200, data)).to eql(17.0)
    end
  end
end
