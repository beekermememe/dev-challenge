class PlayerYearStat

  attr_accessor :year, :at_bats , :league,
              :team_id, :games, :at_bats , :runs , :hits, 
              :two_base_hit ,:three_base_hit , :home_runs,
              :runs_batted_in, :batting_average, :slugging_percentage

  def initialize(stats = {})
    stats.each do |k,v|
      self.send("#{k}=",v)
    end
    if self.at_bats && self.at_bats > 0
      self.batting_average = self.hits.to_f/self.at_bats.to_f
      self.slugging_percentage = calculate_slugging_percentage
    else
      self.batting_average = 0.0
      self.slugging_percentage = 0.0
    end
  end

  def calculate_slugging_percentage
    if self.at_bats > 0
      slugging_percentage = (self.hits.to_i - self.two_base_hit.to_i - self.three_base_hit.to_i - self.home_runs.to_i)
      slugging_percentage += (2* self.two_base_hit.to_i)
      slugging_percentage += (3*self.three_base_hit.to_i)
      slugging_percentage += (4*self.home_runs.to_i)
      slugging_percentage = slugging_percentage.to_f / self.at_bats.to_f
    end
    slugging_percentage
  end

end