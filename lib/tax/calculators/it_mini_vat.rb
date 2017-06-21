module Tax::Calculators
  class ItMiniVat < Abstract

    @@rateINPS = 4;
	  @@rateINPSamount = 600;
	  @@percentualSostitutiva = 67;
	  @@impostaSostitutiva = 5;
	  @@sogliaINPS = 15000;
	  @@percentualeINPS = 24;
	  @baseImponibile;

    def initialize
      super
    end

    def self.issue()
      ItMiniVat.new
    end

    def calculate
      @baseImponibile = (@@percentualSostitutiva * get_Lordo) / 100

      @taxes = []
      add_imposta_sostitutiva
      add_rate_fisse_INPS
      add_INPS

      taxes
    end

    def get_Lordo
      sales
    end
    def add_rate_fisse_INPS
      (1..@@rateINPS).each do |n|
        e = Entry.new(@@rateINPSamount, "Rata #{n}")
        add_tax_entry e
      end
    end

    def add_imposta_sostitutiva
      iSostitutivaAmount = (@@impostaSostitutiva * @baseImponibile).to_f / 100
      iSostitutiva = Entry.new(iSostitutivaAmount, "Imposta sostitutiva al 5%")
      add_tax_entry iSostitutiva
    end

    def add_INPS
      inpsBase = [0, @baseImponibile - @@sogliaINPS].max 
      inpsAmount = (inpsBase * @@percentualeINPS).to_f / 100

      inps = Entry.new(inpsAmount, "Prelievo INPS 24% sopra soglia #{@@sogliaINPS} fino a base imponibile #{@baseImponibile}")

      add_tax_entry inps
    end

    def tax_breakdown
      puts @tax_entries
      @tax_entries.each do |t|
        puts t.description + " " + t.amount
      end
    end
  end
end
