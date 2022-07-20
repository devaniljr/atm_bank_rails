require 'rails_helper'

RSpec.describe Account, :type => :model do
  subject {
    described_class.new(name: "José",
                        email: "jose@gmail.com",
                        password: "123456",
                        password_confirmation: "123456")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without name" do
    subject.name = nil

    expect(subject).to be_invalid
  end

  it "is not valid without email" do
    subject.email = nil

    expect(subject).to be_invalid
  end

  it "is not valid without password combination" do
    subject.password = "123456"
    subject.password_confirmation = "654321"

    expect(subject).to be_invalid
  end

  it "is not valid if start with balance > 0.0" do
    expect(subject.balance.to_f).to be(0.0)
  end

  it "is not valid if start with active equal to false" do
    expect(subject.active).to be_truthy
  end
end
