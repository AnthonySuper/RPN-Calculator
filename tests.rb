#!/usr/bin/env ruby
require "./calculator"
require "minitest/spec"
require "minitest/autorun"

describe Calculator do
  before do
    @calc = Calculator.new
  end

  describe "the README scenario" do
    def block_one
      @calc.input("1")
      @calc.input("2")
      @calc.input("+")
    end

    def block_two
      @calc.input("2")
      @calc.input("*")
    end

    def block_three
      @calc.input("4")
      @calc.input("-")
    end

    it "works up to the first operator" do
      assert_equal 3, block_one
    end

    it "works up to the second operator" do
      block_one
      assert_equal 6, block_two
    end

    it "works up to the third operator" do
      block_one
      block_two
      assert_equal 2, block_three
    end
  end
  
  describe "calculations with 3+ inputs" do
    it "works with 3 inputs" do
      @calc.input("5")
      @calc.input("1")
      @calc.input("2")
      assert_equal 3, @calc.input("+")
      assert_equal 15, @calc.input("*")
    end
  end

  describe "error scenarios" do
    it "raises an argument error on bad input" do
      assert_raises ArgumentError do
        @calc.input("Garbage")
      end
    end

    it "raises when we can't do an operation" do
      assert_raises ArgumentError do
        @calc.input("1")
        @calc.input("*")
      end
    end

    it "preserves the stack when we can't do an operation" do
      begin
        @calc.input("1")
        @calc.input("*")
      rescue ArgumentError
        @calc.input("2")
        assert_equal 3, @calc.input("+")
      end
    end
  end
end
