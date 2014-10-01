require 'rubygems'
require 'stats_reader'
require 'team_stats'
require 'most_improved'
require 'triple_crown'
class Runner

  def initialize
  end


  def answer_the_questions(most_improved_data,triple_crown_for_al, triple_crown_for_nl, team_lookup_data)
    puts team_lookup_data["OAK"].get_batting_average(2007)

    puts "The most improved player for 2011 was #{most_improved_data[2011].name}"

    if triple_crown_for_al[2012].count == 1
      puts "In 2012 - the triple crown winner for the AL was #{triple_crown_for_al[2012][0].name}"
    elsif triple_crown_for_al[2012].count > 2
      print "In 2012 - the triple crown winner for the AL where "
      triple_crown_for_al[2012].each { |winner| print "#{winner.name} " }
      print "/n"
    end

    if triple_crown_for_nl[2012].count == 1
      puts "In 2012 - the triple crown winner for the NL was #{triple_crown_for_nl[2012][0].name}"
    elsif triple_crown_for_nl[2012].count > 2
      print "In 2012 - the triple crown winner for the NL where "
      triple_crown_for_nl[2012].each { |winner| print "#{winner.name} " }
      print "/n"
    end
  end

  def run_tasks
    player_lookup_data = build_player_data
    team_lookup_data = extract_team_data(player_lookup_data.values)
    most_improved_data = MostImproved.create_most_improved_lookup(player_lookup_data.values)
    triple_crown_for_al, triple_crown_for_nl = TripleCrown.get_winners_for_both_leagues(player_lookup_data.values)
    answer_the_questions(most_improved_data,triple_crown_for_al, triple_crown_for_nl, team_lookup_data)
  end

  def build_player_data
    base_player_stats = StatsReader.read_stats_data("src_data/Batting-07-12.csv")
    StatsReader.read_player_data("src_data/Master-small.csv",base_player_stats)
  end

  def extract_team_data(player_data)
    team_stats_generator = TeamStats.new
    team_stats_generator.build_team_stats(player_data)
  end
end

runner = Runner.new
runner.run_tasks