# encoding: utf-8
# AnalyzeSocial.rb.rb-a0001 partOf eSeoTool.rb
=begin
  Analýza sociálních sítí
=end

require 'json'
require 'net/http'

class AnalyzeSocial
  def initialize webAddr
    analyzeFb webAddr
    generateHTML
  end

  def analyzeFb(webAddr)
    @fb = askFb webAddr

    puts "*****FB*****\n" + @fb.to_s
    generateHTML
  end

  def askFb(target)
    base_url = "/method/fql.query?query=select%20total_count,like_count,comment_count,share_count,click_count%20from%20link_stat%20where%20url=%27#{target}%27&format=json"
    puts "base-url:" + base_url
    resp = Net::HTTP.get_response('api.facebook.com', base_url)
    data = resp.body
    puts "data:" + data

    result = JSON.parse(data)
    result = result[0]

    # if the hash has 'Error' as a key, we raise an error
    #if result.has_key? 'Error'
    #  raise "web service error"
    #end

    puts "Result FB JSON PARSE:\n" + result.to_s

    return result
  end

  def generateHTML
    @html = generateHTMLSocialHeader + generateHTMLFacebook + generateHTMLSocialEnd
  end

  def generateHTMLSocialEnd
    "</div>"
  end

  def generateHTMLFacebook
    "<div id=\"facebook\"><h4>Facebook:</h4><p>Total Count: #{@fb['total_count'].to_s}</p><p>Like Count: #{@fb['like_count'].to_s}</p><p>Comment Count: #{@fb['comment_count'].to_s}</p><p>Share Count: #{@fb['share_count'].to_s}</p><p>Click Count: #{@fb['click_count'].to_s}</p></div>"
  end

  def generateHTMLSocialHeader
    "<div id=\"socialStatistics\"><h3>Social Statistics</h3>"
  end

  def getHtml
    return @html
  end
end