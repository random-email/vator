module Tax::Calculators
  class Abstract

    def initialize
      @sales = []
      @expenses = []
      @tax_entries = []
    end

    def calculate
      raise 'This method should be overridden!'
    end

    def self.issue()
      raise 'This method should be overridden!'
    end

    def add_sale(amount)
      if is_valid_amount? amount
        append(amount, @sales)
      else
        raise_not_valid_amount
      end
    end

    def add_expense(amount)
      if is_valid_amount? amount
        append(amount, @expenses)
      else
        raise_not_valid_amount
      end
    end

    def add_tax_entry(entry)
      append(entry, @tax_entries)
    end

    def is_valid_amount?(amount)
      amount.is_a? Numeric
    end

    def append(amount, target)
      target.append(amount)
    end

    def raise_not_valid_amount
      raise 'I was expecting a number, sorry!'
    end

    def taxes
      total = 0
      @tax_entries.each do |e|
        total += e.amount
      end
      total
    end

    def sales
      @sales.sum
    end

    def expenses
      @expenses.sum
    end

  end
end
