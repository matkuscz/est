#Analyzator.rb
=begin

=end

require './app/analyze/AnalyzeRanks'


class Analyzator
  def initialize page
    ranks = AnalyzeRanks.new(page.webAddr)
    puts "Alexa US: " + ranks.ranking[:alexa_us].to_s
    puts "Alexa Country: " + ranks.ranking[:alexa_global].to_s
    puts "Google: " + ranks.ranking[:google].to_s
    puts "Mozzila: " + ranks.ranking[:moz_rank].to_s
    puts "Page Authority: " + ranks.ranking[:page_authority].to_s

    keywords =
  end

end