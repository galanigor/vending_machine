require "spec_helper"

RSpec.describe VendingMachine do
  let(:vending_machine) { described_class.new }

  describe ".invalid_coins" do
    let(:coins) { [0.75, 1, 2, 3, 4, 5] }

    subject { described_class.invalid_coins(coins) }

    it "returns invalid coins" do
      expect(subject).to match_array([0.75, 4])
    end
  end

  describe "#add_slot" do
    let(:id) { 42 }
    let(:product_name) { "Sprite" }
    let(:product_count) { 10 }
    let(:product_cost) { 22 }

    subject do
      vending_machine.add_slot(
        id: id,
        product_name: product_name,
        product_count: product_count,
        product_cost: product_cost
      )
    end

    it "adds product successfully" do
      expect {
        subject 
      }.to change { vending_machine.slots.count }.from(0).to(1)

      new_slot = vending_machine.slots.last

      expect(new_slot.id).to eq(id)
      expect(new_slot.product_name).to eq(product_name)
      expect(new_slot.product_count).to eq(product_count)
      expect(new_slot.product_cost).to eq(product_cost)
    end

    context "with slot id not unique" do
      before do
        vending_machine.add_slot(
          id: id,
          product_name: product_name,
          product_count: product_count,
          product_cost: product_cost
        )
      end

      it "raises validation error" do
        expect {
          subject
        }.to raise_error(VendingMachine::SlotIdTaken)
      end
    end
  end

  describe "#get_change" do
    before do
      vending_machine.add_slot(
        id: 1,
        product_name: "test",
        product_count: 1,
        product_cost: 1
      )
      vending_machine.select_slot(1)
    end

    subject { vending_machine.get_change }

    it "calls VendingMachine::ChangeCalculator" do
      expect(VendingMachine::ChangeCalculator).to receive(:call).with(0, 1)

      subject
    end
  end

  describe "#get_slot_by_id" do
    let(:id) { 42 }

    subject { vending_machine.get_slot_by_id(id) }

    describe "with no slot with such id" do
      it "raises NoSlotWithId error" do
        expect {
          subject
        }.to raise_error(VendingMachine::NoSlotWithId)
      end
    end

    context "when slot with id is present" do
      before do
        vending_machine.add_slot(
          id: id,
          product_name: "test",
          product_count: 1,
          product_cost: 1
        )
      end

      it "returns the slot" do
        expect(subject.id).to eq(id)
      end
    end
  end
end
