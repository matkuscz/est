

class AnalyzeFeeds
  def initialize html
    analyzeHTMLforFeeds html
    generateHTML

  end

  def generateHTML
    atomHtml = "<div id=\"feeds_atom\"><p>ATOM: #{@atomLinks[0].to_s}</p></div>"
    rssHtml = "<div id=\"feeds_rss\"><p>RSS: #{@rssLinks[0].to_s}</p></div>"

    @html = "<div id=\"feeds\">
              <h3>Feeds:</h3>#{atomHtml}#{rssHtml}
            </div>"
  end

  def analyzeHTMLforFeeds(html)
    parse html

  end

  def parse(html, feedType = :all)
    @rssLinks = scanForTag(html, 'rss')
    @atomLinks = scanForTag(html, 'atom')

    case feedType
      when :all
        (@rssLinks + @atomLinks).uniq
      when :rss
        @rssLinks.empty? ? @atomLinks : @rssLinks
      when :atom
        @atomLinks.empty? ? @rssLinks : @atomLinks
    end
  end

  def scanForTag(html, type)
    urls(html, 'link', type) + urls(html, 'a', type)
  end

  def urls(html, tag, type)
    tags = html.scan(/(<#{tag}.*?>)/).flatten
    feedTags = collect(tags, type)
    feedTags.map do |tag|
      matches = tag.match(/.*href=['"](.*?)['"].*/)
      if matches.nil?
        url = ''
      else
        url = matches[1]
      end

      url =~ /^http.*/ ? url : nil

    end.compact
  end

  def collect(tags, type)
    tags.collect { |t| t if feed?(t,type) }.compact
  end

  def feed?(html, type)
    html =~ /.*type=['"]application\/#{type}\+xml['"].*/
  end

  def getHTML
    return @html
  end

end