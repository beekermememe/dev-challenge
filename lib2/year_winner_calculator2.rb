MINIMUM_AT_BATS_FOR_MOST_IMPROVED = 200

class YearWinnerCalculator2
  class << self
    def get_most_improved(year,players)
      best_so_far = 0.0
      most_improved_player = nil
      players.each do |player|
        stats_for_year = player.stats_for_year(year)
        stats_for_prev_year = player.stats_for_year((year.to_i - 1).to_s)
        next if stats_for_year.nil? || stats_for_prev_year.nil?  ||
          stats_for_prev_year.ab.to_i < MINIMUM_AT_BATS_FOR_MOST_IMPROVED || 
          stats_for_year.ab.to_i < MINIMUM_AT_BATS_FOR_MOST_IMPROVED # skip this stat since improvent cannot be calculcated
        improvement = stats_for_year.batting_average - stats_for_prev_year.batting_average
        if improvement > best_so_far
          best_so_far = improvement
          most_improved_player = player
        end
      end
      return most_improved_player, best_so_far
    end

    def get_triple_crown_winner(players)

    end
  end
end