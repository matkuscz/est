#Analyzator.rb
=begin

=end

require './app/analyze/AnalyzeRanks'
require './app/analyze/EseoKeywordAnalyze'
require './app/analyze/AnalyzeBacklinks'
require './app/analyze/AnalyzeIndexes'
require './app/analyze/social/AnalyzeSocial'


class Analyzator

  def initialize page
    @addr = page.webAddr
    @ranks = AnalyzeRanks.new(page.webAddr)
    @backlinks = AnalyzeBacklinks.new(page.webAddr)
    @indexes = AnalyzeIndexes.new(page.webAddr)
    @keywordsInLinks = EseoKeywordAnalyze.new(page.getLinksText)
    @social = AnalyzeSocial.new(page.webAddr)

    #@backlinks = AnalyzeBacklinks.new(page.webAddr)
    #puts "Alexa US: " + ranks.ranking[:alexa_us].to_s
    #puts "Alexa Country: " + ranks.ranking[:alexa_global].to_s
    #puts "Google: " + ranks.ranking[:google].to_s
    #puts "Mozzila: " + ranks.ranking[:moz_rank].to_s
    #puts "Page Authority: " + ranks.ranking[:page_authority].to_s


    @htmlHeader =
        "<!DOCTYPE html><html lang=\"en\">
      <head>
      <meta charset=\"utf-8\" />
      <title>eWorkers SEO Analytics</title>
      <link rel=\"stylesheet\" href=\"analytics.css\" type=\"text/css\" />
      <script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>
    "


    generateHTMLStatsPage
    keywords = ""



  end

  def generateHTMLStatsPage
    puts "\n*****RaBA BaRA GaBRA*****\n"
    htmls = @htmlHeader.to_s +
        htmlKeywordsInLinksGraf +
        htmlHeaderEnd +
        htmlBodyStart +
        htmlIntro.to_s +
        htmlRanks +
        htmlSocial +
        htmlBacklinks +
        htmlIndexes +
        htmlKeywordsInLinks +
        htmlBodyEnd
    #@htmls = " " + @htmlHeader.to_s
    #+ htmlKeywordsInLinksGraf.to_s
    #+ htmlHeaderEnd.to_s
    #+ htmlBodyStart.to_s
    #+ htmlIntro.to_s
    #+ htmlRanks.to_s
    #+ htmlKeywordsInLinks.to_s
    #+ htmlBodyEnd.to_s
    File.open("./generatedHtml/LinksWordsCountGeneratedBeta.html", "w") { |file| file.write(htmls) }
  end

  def htmlSocial
    @social.getHtml
  end

  def htmlIndexes
    @indexes.getHtml
  end

  def htmlBacklinks
    @backlinks.getHtml
  end

  def htmlIntro
    @timeOfTest = Time.now
    return'<h1>***eSEO Analyze***</h1><h2>Domain: ' + @addr + '</h2>'+'<h3>Time of test: ' + @timeOfTest.to_s + '</h3>'
  end

  def htmlBodyEnd
    '</body>'
  end

  def htmlBodyStart
    '<body>'
  end

  def htmlKeywordsInLinks
    "<div id=\"chart_div\"></div>" + @keywordsInLinks.generateHtmlKeywordCount
  end

  def htmlHeaderEnd
    '</head>'
  end

  def htmlKeywordsInLinksGraf
    return @keywordsInLinks.generateKeywordGraf.to_s
  end

  def htmlRanks
    @ranks.html
  end




end