# Page.rb
=begin

=end

require 'open-uri'
class Page
  attr_reader :linkWordCount
  attr_reader :loadingTime
  attr_reader :webAddr

  def initialize url
    begin

      @webAddr = url

      startOfPageDownload = Time.now
      open("temp.html", "wb") do |file|
        open(url) do |uri|
          file.write(uri.read)
        end
        file.close
        @size = File.size("temp.html")
      end
      endOfPageDownload = Time.now

      @loadingTime = endOfPageDownload - startOfPageDownload

      fileToEscape = File.open("temp.html", "rb")
      contents = fileToEscape.read
      contents.gsub!(/<br \/>/, '_')
      contents.gsub!(/\n/, ' ')
      contents.gsub!(/\r/, ' ')

      open("tempe.html", "wb") do |filee|
        filee.write(contents)
        filee.close
      end





      @html = Nokogiri::HTML(open("tempe.html"))


      puts "AAAA" + @html.to_s

      @html.css('body')

    rescue Errno::ECONNREFUSED => chyba_spojeni
      puts "Nastala chyba: #{chyba_spojeni}"
      raise
    end

    @linksText = Array.new


    generateLinks
    preformatLinkText
    generateLinkWordCount


    @headers = Array.new
    generateHeaders

    puts 'Page generated'

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

  def getSize
    return @size
  end

  def generateLinks
    puts "generateLinks"
    @html.css('a').each { |a| link = a.text




    link.strip!

    #link.gsub!(/\<br \/\>/,' ')
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

  def generateHeaders
      puts ">generate links"
      @html.css('h1').each { |h1| header = h1.text
      header.to_s
      header.strip!
      @headers.push(header) unless header == ""
      }
  end



end
