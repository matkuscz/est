# eSeoKeywordAnalyze.rb.rb-a0001 partOf eSeoTool.rb
=begin
  Musí projet všechny slova na stránce
=end

require 'builder'

class ESeoKeywordAnalyze


  def initialize linkTexts
    @link_word_count = Hash::new(0)
    @html = ""
    getKeywordCount linkTexts
  end

  def getKeywordCount linkTexts
    linkTexts.each { |linkText| @link_word_count.store(linkText, @link_word_count[linkText] + 1) }

    tmp = @link_word_count.sort_by { |key,value| value }
    @link_word_count = tmp.reverse
  end

  def getLinkWordCount
    return @link_word_count
  end

  def getSeoKeywordAnalyzeHtmlOutput
    generateHtmlHeader
    generateHtmlBody
    generateHtmlKeywordCount
    generateHtmlFooter
  end

  def getSeoKeywordAnalyzeHtmlOutputToFile
    File.open("./generatedHtml/LinksWordsCountGenerated.html", "w") { |file| file.write(@html) }
  end

  def generateHtmlHeader
    @html += "<!DOCTYPE html>
      <html lang=\"en\">
      <head>
      <meta charset=\"utf-8\" />
      <title>eWorkers SEO Analytics</title>
      <link rel=\"stylesheet\" href=\"analytics.css\" type=\"text/css\" />
      </head>
    "
  end

  def generateHtmlBody
    @html += "<body id=\"seoAnalytics\">"
    @html += "<h1>eWorkers SEO Tools</h1><h2>Klicova slova v odkazech vcetne cetnosti</h2>"
  end

  def generateHtmlKeywordCount
    puts @link_word_count
    builder = Builder::XmlMarkup.new
    columns = ["Link", "Count"]
    builder.table do |table|
      table.tr do |tr|
        columns.each { |col| tr.th(col) }
      end
      @link_word_count.each do |link|
        table.tr do |tr|
          tr.td(link[0])
          tr.td(link[1])
        end
      end
    end

    @html += builder

  end

  def generateHtmlFooter
    @html += "</body></html>"
  end

end