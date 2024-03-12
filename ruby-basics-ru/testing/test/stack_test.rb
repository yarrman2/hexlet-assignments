# frozen_string_literal: true

require 'minitest/autorun'
require 'power_assert/colorize'
require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @items = %w[Ruby Python JS]
  end

  def test_empy
    stack = Stack.new

    assert do
      stack.empty?
    end
  end

  def test_not_empty
    stack = Stack.new
    stack.push! @items.sample

    assert do
      stack.empty? == false
    end
  end

  def test_push_element
    stack = Stack.new

    item = @items.sample
    stack.push! item

    assert do
      stack.to_a == [item]
    end

    stack.push! item

    assert do
      stack.to_a == [item, item]
    end
  end

  def test_pop_element
    stack = Stack.new
    item = @items.sample

    stack.push! item

    assert do
      stack.empty? == false
    end

    pop_item = stack.pop!

    assert do
      stack.empty?
    end

    assert do
      pop_item == item
    end
  end

  def test_clear_stack
    stack = Stack.new
    n = rand(1..10)
    n.times { stack.push! 1 }

    assert do
      stack.size == n
    end

    stack.clear!

    assert do
      stack.empty?
    end
  end

  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
