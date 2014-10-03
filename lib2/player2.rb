class Player2
  attr_accessor :playerid, :birthyear, :namefirst, :namelast, :player_stats

  def initialize(info)
    info.each do |k,v|
      self.send("#{k.downcase}=",v)
    end
    self.player_stats ||= []
  end

  def name
    return "#{self.namefirst} #{self.namelast}"
  end

  def stats_for_year(year)
    return nil if year.nil? || self.player_stats.nil?
    self.player_stats.each do |player_stat|
      return player_stat if player_stat.yearid == year
    end
    return nil
  end

end
