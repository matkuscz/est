require 'typhoeus'

class AnalyzeSitemap
  def initialize webAddr
    @webAddr = webAddr
    if(@webAddr.to_s[-1] != '/')
      @webAddr += '/'
    end

    checkForSitemap @webAddr
    generateHTML

  end

  def generateHTML
    if(@sitemap[:normalPath]||@sitemap[:XMLPath] == true)
      sitemapPresent = "<div id=\"sitemapFound\"><p>FOUND !!!</p></div>"
    else
      sitemapPresent = "<div id=\"sitemapNotFound\"><p>NOT FOUND !!!</p></div>"
    end


    @html = "<div id=\"analyzedSitemaps\">#{sitemapPresent}</div>"
  end

  def checkForSitemap(webAddr)
    request = Typhoeus::Request.new("http://#{@webAddr.to_s}sitemap")
    hydra = Typhoeus::Hydra.new

    request.on_complete do |response|
      if response.code == 200
        @sitemapOnSitemap = true
      else
        @sitemapOnSitemap = false
      end
    end

    request = Typhoeus::Request.new("http://#{@webAddr.to_s}sitemap.xml")
    hydra = Typhoeus::Hydra.new

    request.on_complete do |response|
      if response.code == 200
        @sitemapOnSitemapXML = true
      else
        @sitemapOnSitemapXML = false
      end
    end

    @sitemap = Hash.new
    @sitemap[:normalPath] = @sitemapOnSitemap
    @sitemap[:XMLPath] = @sitemapOnSitemapXML
  end

  def getSitemap
    return @sitemap
  end

end