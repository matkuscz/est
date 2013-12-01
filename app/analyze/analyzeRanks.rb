#analyzeRanks.rb
=begin

=end

require 'page_rankr'

class AnalyzeRanks
  attr_reader :ranking, :html

  def initialize webAddr
    @ranking = PageRankr.ranks(webAddr)
    @ranking[:srank] = getSrank(webAddr)
    generateHTML
  end

  def getSrank(webAddr)

    server = XMLRPC::Client.new("srank.seznam.cz", "/RPC2", 80)
    def sendRequest(server, webAddr)
      begin
        param = server.call('getRank','0', webAddr, 0)
      rescue XMLRPC::FaultException => e
        puts "Error:"
        puts e.faultCode
        puts e.faultString
      end
    end

    puts "**************SRANK************"
    a = sendRequest(server, webAddr)

    b = a['rank'].to_i.to_int
    b = b/2.55
    b = b.round(0)
    puts b
    return b
  end

  def generateHTML
    @html = "<div id=\"analyzedRanks\">
              <h3>Rank of page, by engine:</h3>
              <div id=\"alexaUS\"><p>Alexa US: #{@ranking[:alexa_us].to_s}</p></div>
              <div id=\"alexaCountry\"><p>Alexa Country: #{@ranking[:alexa_country].to_s}</p></div>
              <div id=\"google\"><p>Google: #{@ranking[:google].to_s}</p></div>
              <div id=\"mozRank\"><p>Moz Rank: #{@ranking[:moz_rank].to_s}</p></div>
              <div id=\"pageAuthority\"><p>Page Authority: #{@ranking[:page_authority].to_s}</p></div>
              <div id=\"s-rank\"><p>S-Rank: #{@ranking[:srank].to_s}</p></div>
            </div>"
  end
end
