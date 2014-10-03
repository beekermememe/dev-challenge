class PlayerYearStat2

  attr_accessor :playerid,:yearid,:league,:teamid,:g,:ab,:r,:h,:_2b,:_3b,:hr,:rbi,:sb,:cs, :batting_average, :slugging_percentage

  def initialize(stats = {})
    stats.each do |k,v|
       k = "_#{k}" if k[0] =~ /[0-9]/
      self.send("#{k.downcase}=",v)
    end
    if self.ab.to_i && self.ab.to_i > 0
      self.batting_average = self.h.to_f/self.ab.to_f
      self.slugging_percentage = calculate_slugging_percentage
    else
      self.batting_average = 0.0
      self.slugging_percentage = 0.0
    end
  end

  def calculate_slugging_percentage
    if self.ab.to_i > 0
      slugging_percentage = (self.h.to_i - self._2b.to_i - self._3b.to_i - self.hr.to_i) +
                            (2* self._2b.to_i) + (3*self._3b.to_i) + (4*self.hr.to_i)
      slugging_percentage += (2* self._2b.to_i)
      slugging_percentage += (3*self._3b.to_i)
      slugging_percentage += (4*self.hr.to_i)
      slugging_percentage = slugging_percentage.to_f / self.ab.to_f
    end
    slugging_percentage
  end

end