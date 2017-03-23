require "enumerable_methods"
#require 'spec_helper'

describe Enumerable do
  before :each do
    @sample_array = (1..10).to_a
    @sample_output = []
  end

  describe "#my_each" do
    context "given no block" do
      it "returns an enumerator" do
        expect(@sample_array.my_each()).to be_an_instance_of(Enumerator)
      end
    end

    context "given a block" do
      it "iterates over the block" do
        @sample_array.my_each() {|num| @sample_output.push(num)}
        expect(@sample_output).to eql(@sample_array)
      end
    end
  end

  describe "#my_select" do
    context "given no block" do
      it "returns an enumerator" do
        expect(@sample_array.my_select()).to be_an_instance_of(Enumerator)
      end
    end

    context "given a block that will evaulate as a boolean" do
      it "returns all values which are true" do
        @sample_output = @sample_array.my_select() {|num| num.even?}
        expect(@sample_output).to eql([2,4,6,8,10])
      end
    end
  end

  describe "#my_any?" do
    context "given no block and a nil collection" do
      it "returns false" do
        expect([nil].my_any?).to eql(false)
      end
    end

    context "given no block and a collection containing true" do
      it "returns true" do
        expect([nil,true,nil].my_any?).to eql(true)
      end
    end

    context "given a block" do
      it "returns true if the block evacluates to true at least once" do
        expect(@sample_array.my_any? {|obj| obj == 6}).to eql(true)
      end
    end
  end

  describe "#my_none?" do
    context "given no block" do
      it "returns true if none are of the collection are true" do
        expect([nil,52,false,5232.23,"dsfse"].my_none?).to eql(true)
      end
    end

    context "given a block that evaluates false" do
      it "returns true" do
        expect(@sample_array.my_none? {|obj| obj == 1111}).to eql(true)
      end
    end

    context "given a block that evaluates true" do
      it "return false" do
        expect(@sample_array.my_none? {|obj| obj == 5}).to eql(false)
      end
    end
  end

  describe "#my_count" do
    context "given no block" do
      it "returns the number of elements in the collection" do
        expect(@sample_array.my_count()).to eql(@sample_array.size)
      end
    end

    context "given a block" do
      it "returns the number of times it evaluates true for a colleciton" do
        expect(@sample_array.my_count {|n| n.even?}).to eql(5)
      end
    end
  end

  describe "#my_map" do
    context "given no block" do
      it "returns an enumerator" do
        expect(@sample_array.my_map()).to be_an_instance_of(Enumerator)
      end
    end

    context "given a block" do
      it "returns a new array containing the blocks output" do
        expect(@sample_array.my_map() {|i| i + 2}).to eql((3..12).to_a)
      end
    end
  end
end
