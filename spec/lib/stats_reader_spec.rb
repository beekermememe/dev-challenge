require "spec_helper"
require 'stats_reader'

describe "StatsReader" do

  context "opening file" do
    it "should open the file passed for stats data" do
      new_data = StatsReader.read_stats_data("#{Dir.pwd}/spec/resources/test_stats_file.csv")
      expect(new_data.count).to eq 1
      expect(new_data["abreubo01"][:stats][0].class).to eq PlayerYearStat
    end

    it "should open the file passed for player data" do
      
    end
  end

  context "parsing player data" do
    it "should have a hash of player data" do
      data = "aaronha01,1934,Hank,Aaron".split(",")
      new_data = StatsReader.read_line_of_player_data({"aaronha01" => {:stats => [PlayerYearStat.new({})]}},data)
      expect(new_data["aaronha01"].class).to eq(Player)
      expect(new_data["aaronha01"].last_name).to eq("Aaron")
      expect(new_data["aaronha01"].birthyear).to eq(1934)
      expect(new_data["aaronha01"].stats[0].class).to eq(PlayerYearStat)

      data = "aaronha01,1934,Hank,Aaron".split(",")
      new_data = StatsReader.read_line_of_player_data({"aaronha01" => {:stats => [PlayerYearStat.new({})]}},data)
      

    end

    it "should not accept bad data" do
      data = "aaronha01,1934,Hank,Aaron".split(",")
      new_data = StatsReader.read_line_of_player_data({"aaronha01" => {:stats => [PlayerYearStat.new({})]}},data)
      expect(new_data["aaronha01"].first_name).to eq("Hank")

    end
  end

  context "parsing stats data" do
    it "should correctly parse a line of data" do
      data = ["abreubo01",2010,"AL","LAA",154,573,88,146,41,1,20,78,24,10]
      new_data = StatsReader.read_line_of_stats_data({},data)
      expect(new_data["abreubo01"][:stats].count).to eq 1
      record = new_data["abreubo01"][:stats][0]
      expect(record.league).to eq "AL"
      expect(record.team_id).to eq "LAA"
      expect(record.year).to eq 2010
      expect(record.games).to eq 154
      expect(record.at_bats).to eq 573
      expect(record.runs).to eq 88
      expect(record.hits).to eq 146
      expect(record.two_base_hit).to eq 41
      expect(record.three_base_hit).to eq 1
      expect(record.home_runs).to eq 20
      expect(record.runs_batted_in).to eq 78
    end

    it "should handle nil data with no numbers" do
      data = ["aardsda01",2012,"AL","NYA",1,nil,nil,nil,nil,nil,nil,nil,nil,nil]
      new_data = StatsReader.read_line_of_stats_data({},data)
      expect(new_data["aardsda01"][:stats].count).to eq 1
      record = new_data["aardsda01"][:stats][0]
      expect(record.league).to eq "AL"
      expect(record.team_id).to eq "NYA"
      expect(record.year).to eq 2012
      expect(record.games).to eq 1
      expect(record.at_bats).to eq 0
      expect(record.runs).to eq 0
      expect(record.hits).to eq 0
      expect(record.two_base_hit).to eq 0
      expect(record.three_base_hit).to eq 0
      expect(record.home_runs).to eq 0
      expect(record.runs_batted_in).to eq 0
    end

    it "should not use incorrectly formatted data" do
      data = ["aardsda01",2012,"AL","NYA",1,nil,nil,nil,nil,nil]
      new_data = StatsReader.read_line_of_stats_data({},data)
      expect(new_data).to eq({})
    end

    it "should return the hash with the record added to it" do
      data = ["abreubo01",2010,"AL","LAA",154,573,88,146,41,1,20,78,24,10]
      new_data = StatsReader.read_line_of_stats_data({},data)
      expect(new_data["abreubo01"].count).to eq 1
    end
  end
end