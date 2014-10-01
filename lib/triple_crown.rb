class TripleCrown
  MIN_AT_BATS_TO_BE_CONSIDERED = 400
  class << self

    def get_winners_for_both_leagues(players)
      al_candidates, nl_candidates = find_candidates_for_each_year(players)
      al_winners = find_triple_crown_winners(al_candidates)
      nl_winners = find_triple_crown_winners(nl_candidates)
      return al_winners,nl_winners
    end

    def find_triple_crown_winners(candidates)
      triple_crown_winners = {}
      candidates.each do |year,players|
        rbi_winners = get_best_rbi_ers(players,year)
        hr_winners = get_highest_home_runners(players,year)
        batter_winners = get_best_batters(players,year)
        triple_crown_winners[year] = is_there_a_winner?(rbi_winners,hr_winners,batter_winners)
      end
      return triple_crown_winners
    end
    # returns a hash where the key is the year and the value is
    # an array of the players for that year

    def find_candidates_for_each_year(all_players)
      al_candidates = {}
      nl_candidates = {}
      all_players.each do |player|
        player.stats.each do |player_stat|
          if player_stat.league.upcase == "NL"
            nl_candidates[player_stat.year] ||= []
            nl_candidates[player_stat.year] << player
          elsif player_stat.league.upcase == "AL"
            al_candidates[player_stat.year] ||= []
            al_candidates[player_stat.year] << player
          end
        end
      end
      return al_candidates, nl_candidates
    end

    # returns a hash of the year and the player who won
    def get_highest_home_runners(players, year)
      highest_hr_total = 0
      home_run_winners = []
      players.each do |player|
        if player.stats_for_year(year).home_runs > highest_hr_total
          home_run_winners = [player]
          highest_hr_total = player.stats_for_year(year).home_runs 
        elsif player.stats_for_year(year).home_runs == highest_hr_total
          home_run_winners << player
        end
      end
      home_run_winners
    end

    def get_best_batters(players,year)
      highest_batting_average = 0
      batting_winners = []
      players.each do |player|
        next unless eligible_for_batting_title?(player,year)
        if player.stats_for_year(year).batting_average > highest_batting_average
          batting_winners = [player]
          highest_batting_average = player.stats_for_year(year).batting_average 
        elsif player.stats_for_year(year).batting_average == highest_batting_average
          batting_winners << player
        end
      end
      batting_winners
    end

    def get_best_rbi_ers(players,year)
      highest_rbi_total = 0
      rbi_winners = []
      players.each do |player|
        if player.stats_for_year(year).runs_batted_in > highest_rbi_total
          rbi_winners = [player]
          highest_rbi_total = player.stats_for_year(year).runs_batted_in 
        elsif player.stats_for_year(year).runs_batted_in == highest_rbi_total
          rbi_winners << player
        end
      end
      rbi_winners
    end


    def is_there_a_winner?(rbi_winners_for_al,hr_winners_for_al,batter_winners_for_al)
      remaining = []
      rbi_winners_for_al.each do |rbi_winner|
        if hr_winners_for_al.include?(rbi_winner) && batter_winners_for_al.include?(rbi_winner)
          remaining << rbi_winner
        end
      end
      remaining
    end

    def eligible_for_batting_title?(player,year)
      player.stats_for_year(year).at_bats >= MIN_AT_BATS_TO_BE_CONSIDERED
    end
  end

end