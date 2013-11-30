#AnalyzeBacklinks.rb

require 'page_rankr/backlinks'

class AnalyzeBacklinks

  def initialize webAddr
    @backlinks = PageRankr.backlinks(webAddr)
    @html = generateHTML
  end

  def generateHTML
    @html = "<div id=\"analyzedBacklinks\">
              <h3>Number of backlinks to page, by engine:</h3>
              <div id=\"alexa\"><p>Alexa: #{@backlinks[:alexa].to_s}</p></div>
              <div id=\"bing\"><p>Bing: #{@backlinks[:bing].to_s}</p></div>
              <div id=\"google\"><p>Google: #{@backlinks[:google].to_s}</p></div>
              <div id=\"yahoo\"><p>Yahoo: #{@backlinks[:yahoo].to_s}</p></div>
            </div>"
  end

  def getHtml
    return @html
  end
end