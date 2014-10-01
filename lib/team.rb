class Team
  DEBUG = false
  attr_accessor :team_code, :stats

  def initialize(team_code)
    @team_code = team_code
    @stats = {}
  end

  def update_team_stats_data(player_stat)
    return if player_stat.nil? || player_stat.batting_average.nil? || player_stat.year.nil?
    @stats[player_stat.year] ||= []
    @stats[player_stat.year] << player_stat.batting_average
  end

  def get_batting_average(year)
    begin
      statlist = @stats[year]
      if statlist.count > 0
        player_count = statlist.count
        total_batting = 0
        statlist.each { |player_batting_average| total_batting += player_batting_average }
        return "The batting average for #{team_code} for #{year} was #{total_batting/player_count}%"
      else
        return "No stats for #{@team_code} in #{year}"
      end
    rescue Exception => e
      puts "Failed to get team batting average - #{@team_code} - #{year} - #{e.message} / #{e.backtrace}" if DEBUG
      return "No stats for #{@team_code} in #{year}"
    end
  end

end