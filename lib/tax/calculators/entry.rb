module Tax::Calculators
  class Entry

    attr_reader :amount
    attr_reader :description

    def initialize(amount, description)
      @amount = amount
      @description = description
    end
  end
end
