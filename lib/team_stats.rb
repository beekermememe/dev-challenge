require 'team'

class TeamStats

  attr_accessor :teams, :players

    def initialize()
      @teams = {}
    end

    def build_team_stats(player_stats)
      player_stats.each do |player|
        @teams = extract_and_update_team_stat_from_player_info(player,@teams)
      end
      @teams
    end

    def extract_and_update_team_stat_from_player_info(player,teams)
      player.stats.each do |stat|
        teams[stat.team_id] ||= Team.new(stat.team_id)
        teams[stat.team_id].update_team_stats_data(stat)
      end
      teams
    end
end