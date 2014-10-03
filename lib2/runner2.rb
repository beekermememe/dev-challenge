require 'rubygems'
require 'stats_reader2'
require 'year_winner_calculator2'
class Runner2

  def initialize
  end


  def answer_the_questions(most_improved_data,triple_crown_for_al, triple_crown_for_nl, team_lookup_data)
    puts team_lookup_data["OAK"].get_batting_average(2007)
    puts "The most improved player for 2011 was #{most_improved_data[2011].name}"
    puts "In 2012 - the triple crown winner for the AL was #{triple_crown_for_al[2012][0].name}"
    puts "In 2012 - the triple crown winner for the AL was #{triple_crown_for_nl[2012][0].name}"

  end

  def run_tasks(players_filename, stats_filename,team_code,year)
    player_lookup_data, team_data = StatsReader2.read_all_data(players_filename, stats_filename,team_code,year)
    show_batting_results(team_code,year,team_data)
    most_improved_player, improvement = YearWinnerCalculator2.get_most_improved("2011",player_lookup_data.values)
    puts "The most improved player for 2011 was #{most_improved_player.name} - Year of Year improvement : #{improvement}"
  end

  def show_batting_results(team,year,results)
    puts "#{team}, #{year} - player batting average #{(results.count)} players : \n=======\n #{(eval results.map { |res| res.batting_average }.join("+")) / results.count}"
  end

end

runner = Runner2.new
runner.run_tasks("src_data/Master-small.csv", "src_data/Batting-07-12.csv","OAK","2007")