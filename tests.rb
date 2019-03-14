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
end
