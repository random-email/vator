module Tax
  class Factory
    def hello
      "I am greeting you"
    end

    def self.registered
      {
        "it_mini_vat" => Tax::Calculators::ItMiniVat
      }
    end

    def self.make(mode)
      if mode_exists? mode
        build_mode mode
      else
        raise "Sorry, I can't build `#{mode}`. That mode is not yet available"
      end
    end

    def self.mode_exists?(mode)
      if registered.key? mode
        true
      else
        false
      end
    end

    def self.build_mode(mode)
      registered[mode].issue
    end

  end

end
