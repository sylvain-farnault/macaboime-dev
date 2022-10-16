module SeasonsHelper
  class CurrentSeasonYears
    def self.get
      current_year = Time.now.year
      start_year = (Time.now > Time.new(current_year,8,15)) ? current_year : (current_year - 1)

      start_year.to_s + "-" + (start_year + 1).to_s
    end
  end
end
