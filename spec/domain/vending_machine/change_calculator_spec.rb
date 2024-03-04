require "spec_helper"

RSpec.describe VendingMachine::ChangeCalculator do
  let(:total_sum) { 26.75 }
  let(:used_sum) { 10 }

  subject { described_class.call(total_sum, used_sum) }

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
end
