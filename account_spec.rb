require "rspec"

require_relative "account"

describe Account do

  let(:acct_number){"1234567890"}
  let(:account){ Account.new(acct_number) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a bank account with an account number and starting balance" do
        expect{ Account.new(acct_number) }.to_not raise_error
      end
    end

    context "with invalid input" do
      it "should raise an error" do
        expect{ Account.new("1234")}.to raise_error
      end
    end
  end

  describe "#transactions" do
    it "first item in the array should equal to 0" do
      expect( account.transactions[0] ).to eq(0)
    end
  end

  describe "#balance" do
    it "should sum the transactions and reflect in the balance" do
      account.deposit!(10)
      account.withdraw!(3)
      expect( account.balance ).to eq(7)
    end
  end

  describe "#account_number" do
    it "replaces first 6 digits with random strings" do
      expect( account.acct_number ).to eq("******7890")
    end
  end

  describe "deposit!" do
    it "adds deposited amount to transactions array" do
      account.deposit!(10)
      expect( account.transactions[-1] ).to eq(10)
    end

    it "should raise a NegativeDepositError if deposited amount is less than 0" do
      expect{ account.deposit!(-1) }.to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "adds withdrawn amount to transactions array" do
      account.deposit!(10)
      account.withdraw!(5)
      expect( account.transactions[-1] ).to eq(-5)
    end

    it "should raise an OverdraftError if balance is less than 0" do
      expect{ account.withdraw!(100) }.to raise_error(OverdraftError)
    end

  end
end
