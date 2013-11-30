#AnalyzeIndexes.rb

require 'page_rankr/backlinks'

class AnalyzeIndexes

  def initialize webAddr
    @indexes = PageRankr.indexes(webAddr)
    @html = generateHTML
  end

  def generateHTML
    @html = "<div id=\"analyzedIndexes\">
              <h3>Number of indexed pages, by engine:</h3>
              <div id=\"bing\"><p>Bing: #{@indexes[:bing].to_s}</p></div>
              <div id=\"google\"><p>Google: #{@indexes[:google].to_s}</p></div>
              <div id=\"yahoo\"><p>Yahoo: #{@indexes[:yahoo].to_s}</p></div>
            </div>"
  end

  def getHtml
    return @html
  end
end