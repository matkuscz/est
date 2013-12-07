# encoding: utf-8
# AnalyzeHTMLValidity.rb-a0001
=begin
  Zanalyzuje validitu HTML
=end

require 'w3c_validators'
include W3CValidators

class AnalyzeHTMLValidity
  def initialize webAddr
    puts 'validating HTML'

    @validator = MarkupValidator.new
    @results = @validator.validate_uri(webAddr)

    if @results.is_valid?
      puts 'HTML Valid'
    else
      puts 'HTML Not Valid'
    end
    generateHTML
  end

  def getResult
    return @results
  end

  def generateHTML
    if @results.errors.length > 0
      text = "Sorry, your HTML is NOT VALID<br>#{@results.errors.length} error(s) found !"
    else
      text = 'HTML is VALID!'
    end
    @html = "<div id=\"HTMLValidity\"><h3>HTML Validity:</h3><div id=\"HTMLValidityValue\"><p>#{text}</p></div></div>"
  end

  def getHTML
    return @html
  end

end
