class Calculator
  def initialize
    @stack = []
  end

  ## 
  # Take in a string token and perform a calculation on it
  # If this token is an operator, it will return the result of
  # the operation. Otherwise, it will return nil.
  def input token
    if is_number?(token)
      @stack.push(token.to_f)
      nil
    elsif is_operator?(token)
      calc_operator(token)
    else
      raise InvalidTokenError.new(token)
    end
  end

  class InvalidTokenError < ArgumentError
  end

  protected

  def calc_operator token
    raise InvalidTokenError if @stack.length < 2
    arg2 = pop!
    arg1 = pop!
    res = get_operation(token).call(arg1, arg2)
    @stack.push(res)
    res
  end


  def get_operation token
    OPERATOR_MAP[token]
  end


  def is_number? token
    Float(token) && true rescue false
  end

  def is_operator? token
    OPERATOR_MAP.keys.include?(token)
  end

  # We could use metaprogramming for (via `send`) but this is
  # easier to understand: a map from the operator to a lambda
  # that actually applies the operation
  OPERATOR_MAP = {
    "+" => lambda {|a, b| a + b},
    "-" => lambda {|a, b| a - b},
    "/" => lambda {|a, b| a / b},
    "*" => lambda {|a, b| a * b}
  }

  def pop!
    r = @stack.pop
    raise ArgumentError if r.nil?
    r
  end
end
