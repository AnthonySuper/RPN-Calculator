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

  ##
  # Basic error indicating that the user tried to input an invalid
  # token of some variety. Note that this is state-sensitive:
  # if the stack only holds one operand, then inputting an 
  # operation token is considered inputting an invalid token.
  class InvalidTokenError < ArgumentError
  end

  protected

  ##
  # Do the actual calculation given an operator-token
  def calc_operator token
    ##
    # We need two operands to perform an operation, so we 
    # raise `InvalidTokenError` if we don't have those 
    # (as at that moment of execution operator-tokens are invalid).
    raise InvalidTokenError if @stack.length < 2
    arg2 = pop!
    arg1 = pop!
    res = get_operation(token).call(arg1, arg2)
    @stack.push(res)
    res
  end


  ##
  # Get the operation proc for a given operator-token.
  # If the token is *not* an operator-token this will return nil.
  def get_operation token
    OPERATOR_MAP[token]
  end


  ## 
  # Determine if a token is a valid number
  def is_number? token
    Float(token) && true rescue false
  end

  ##
  # Determine if a token is a valid operator
  def is_operator? token
    OPERATOR_MAP.keys.include?(token)
  end

  # We translate operator-tokens into operations via a simple map
  # of token-to-operation. This makes determining valid
  # operator-tokens easy: if it has a key in the map, it's a token
  # for an operation we can actually do.
  #
  # We could use metaprogramming for (via `send`) but this is
  # easier to understand. We could also have a bunch of subclasses
  # of an `Operation` class, but Ruby has lambdas so we might as
  # well use them!
  OPERATOR_MAP = {
    "+" => lambda {|a, b| a + b},
    "-" => lambda {|a, b| a - b},
    "/" => lambda {|a, b| a / b},
    "*" => lambda {|a, b| a * b}
  }

  ##
  # Pop an item off the stack.
  # Raises if this is not possible.
  def pop!
    r = @stack.pop
    raise ArgumentError if r.nil?
    r
  end
end
