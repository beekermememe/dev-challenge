require 'player'

class MostImproved
  MINIMUM_AT_BATS_FOR_MOST_IMPROVED = 200
  class << self
    
    def create_most_improved_lookup(player_data)
      improved_player_list = {}
      years = 2000..2014
      years.each do |year|
        current_year = year
        previous_year = year - 1
        most_improved_player = get_best_for_year(player_data,current_year,previous_year).first
        improved_player_list[year] = most_improved_player
      end
      improved_player_list
    end

    def is_player_eligible_for_most_improved?(player_data,current_year,previous_year)
      !player_data.stats_for_year(current_year).nil? && !player_data.stats_for_year(previous_year).nil? &&
       player_data.stats_for_year(current_year).at_bats > MINIMUM_AT_BATS_FOR_MOST_IMPROVED &&
       player_data.stats_for_year(previous_year).at_bats > MINIMUM_AT_BATS_FOR_MOST_IMPROVED
    end

    def get_improvement(player,current_year,previous_year)
      increase_batting_average = player.stats_for_year(current_year).batting_average - player.stats_for_year(previous_year).batting_average
    end

    def get_best_for_year(player_data,current_year,previous_year)
      best_players = []
      best_player_score = 0
      player_data.each do |player|
        if is_player_eligible_for_most_improved?(player,current_year,previous_year)
          improvement = get_improvement(player,current_year,previous_year)
          if best_player_score < improvement
            best_players = [player]
            best_player_score = improvement
          elsif best_player_score == improvement
            best_players << player
          end
        end
      end
      best_players 
    end
  end
end

