require "spec_helper"

RSpec.describe VendingMachine::ChangeCalculator do
  let(:total_sum) { 26.75 }
  let(:used_sum) { 10 }
  let(:stored_coins) do
    VendingMachine::AVAILABLE_COINS.zip(Array.new(VendingMachine::AVAILABLE_COINS.count) { 5 }).to_h
  end

  subject { described_class.call(total_sum, used_sum, stored_coins) }

  it "returns the change in expected format" do
    expected_change = [
      { value: 5, count: 3 },
      { value: 1, count: 1 },
      { value: 0.5, count: 1 },
      { value: 0.25, count: 1 }
    ]

    expect(subject).to match_array(expected_change)
  end

  context "with no change" do
    let(:used_sum) { total_sum }

    it "returns no change" do
      expect(subject).to eq([])
    end
  end

  context "with not enough coins for change" do
    let(:stored_coins) do
      VendingMachine::AVAILABLE_COINS.zip(Array.new(VendingMachine::AVAILABLE_COINS.count) { 0 }).to_h
    end

    it "raises the NotEnoughCoinsForChange error" do
      expect {
        subject
      }.to raise_error(VendingMachine::ChangeCalculator::NotEnoughCoinsForChange)
    end
  end

  context "with some stored coins missing" do
    before do
      stored_coins[5] = 0
    end

    it "returns the change in expected format" do
      expected_change = [
        { value: 3, count: 5 },
        { value: 1, count: 1 },
        { value: 0.5, count: 1 },
        { value: 0.25, count: 1 }
      ]
  
      expect(subject).to match_array(expected_change)
    end
  end
end
