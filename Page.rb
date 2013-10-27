class Page
  attr_reader :linkWordCount

  def initialize url
    begin
      @html = Nokogiri::HTML(open(url))
    rescue Errno::ECONNREFUSED => chyba_spojeni
      puts "Nastala chyba: #{chyba_spojeni}"
      raise
    end

    @linksText = Array.new

    generateLinks
    preformatLinkText
    generateLinkWordCount
  end

  def getHtml
    puts "getHtml"
    return @html
  end

  def getLinksText
    puts "getLinksText"
    return @linksText
  end

  def getLinkWordCount
    return @link_word_count
  end

  def generateLinks
    puts "generateLinks"
    @html.css('a').each { |a| link = a.text
    link.to_s
    link.strip!
    @linksText.push(link) unless link == ""
    }
  end



  def generateLinkWordCount
    puts "generateWordCount"
    @link_word_count = Hash.new(0)
    @linksText.each { |linkText| @link_word_count.store(linkText, @link_word_count[linkText] + 1) }

    puts @link_word_count.inspect
  end

  def preformatLinkText
    puts "preformatLinkText"
  end

  def replaceNationalCzechChars text
    puts "replaceNationalCzechChars"
  end

  def analyzeKeywords
    puts "Analyze Keywords"
  end
end