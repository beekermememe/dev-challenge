class Player
  attr_accessor :first_name, :last_name, :stats, :birthyear

  def initialize(first_name, last_name, birthyear, stats = [])
    self.first_name = first_name
    self.last_name = last_name
    self.stats = stats
    self.birthyear = birthyear
  end

  def name
    return "#{self.first_name} #{self.last_name}"
  end

  def stats_for_year(year)
    return nil if year.nil? || self.stats.nil?
    self.stats.each do |player_stat|
      return player_stat if player_stat.year == year
    end
    return nil
  end

end
