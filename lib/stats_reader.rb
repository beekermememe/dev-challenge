require 'player_year_stat'
require 'player'

class StatsReader
  DEBUG = false
  MINIMUM_AMOUNT_OF_COLUMNS_FOR_STATS = 12
  MINIMUM_AMOUNT_OF_COLUMNS_FOR_PLAYER_INFO = 4

  class << self

    def read_stats_data(filename,raw_data = {})
      File.open(filename,"r") do |file|
        file.each do |lines|
          line_count = 0
          lines.split("\r").each do |line|
            raw_data = read_line_of_stats_data(raw_data,prep_line(line)) if line_count > 0
            line_count += 1
          end
        end
      end
      raw_data
    end

    def read_player_data(filename,raw_data={})
      File.open(filename,"r") do |file|
        file.each do |lines|
          line_count = 0
          lines.split("\r").each do |line|
            raw_data = read_line_of_player_data(raw_data,prep_line(line)) if line_count > 0
            line_count += 1
          end
        end
      end
      raw_data
    end

    def read_line_of_stats_data(existing_data,data)
      if data.count < MINIMUM_AMOUNT_OF_COLUMNS_FOR_STATS
        puts "Failed to parse stats data for line #{data.inspect}" if DEBUG
        return existing_data
      end
      existing_data[data[0]] ||= { stats: [] }
      
      player_stat = PlayerYearStat.new({
        year: data[1].to_i,
        league: data[2],
        team_id: data[3],
        games: data[4].to_i,
        at_bats: data[5].to_i,
        runs: data[6].to_i,
        hits: data[7].to_i,
        two_base_hit: data[8].to_i,
        three_base_hit: data[9].to_i,
        home_runs: data[10].to_i,
        runs_batted_in: data[11].to_i
      })

      existing_data[data[0]][:stats] << player_stat
      existing_data
    end

    def read_line_of_player_data(existing_data,data)

      if data.count < MINIMUM_AMOUNT_OF_COLUMNS_FOR_PLAYER_INFO
        puts "Failed to parse player info for line #{data.inspect}" if DEBUG
        return existing_data
      end

      if existing_data[data[0]].nil?
        puts "Failed to find batting data player info for line #{data.inspect}" if DEBUG
        return existing_data
      end
      return existing_data if existing_data[data[0]].class == Player # duplicate data skip this
      player = Player.new(
        data[2],
        data[3],
        data[1].to_i,
        existing_data[data[0]][:stats]
      )
      existing_data[data[0]] = player
      existing_data
    end

    def prep_line(line)
      line.strip().split(",")
    end

  end

end
