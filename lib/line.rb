class Line
  # existed states:
  #    :deleted
  #    :insert
  #    :changed
  #    :unchanged

  attr_reader :state, :value

  def initialize(value, state)
    @value = value
    @state = state
  end
end
