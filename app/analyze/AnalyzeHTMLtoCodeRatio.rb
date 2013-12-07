#AnalyzeHTMLtoCodeRatio.rb

=begin
Analyzes HTML to code ratio,
  based on simple regular expression
=end

class AnalyzeHTMLtoCodeRatio

  def initialize html
    @ratio = doTheMath(html)
    puts "HTML to code ratio:" + @ratio.to_s
    generateHTML
  end

  def doTheMath(html)
    countAll = html.gsub(/\s/, '').size
    countContent = html.gsub(/\s/, '').downcase.match(/<body.*>(.*)<\/body>/m)[0].gsub(/<\/?[^>]*>/, '').size
    preResult = countContent.to_f / countAll
    preResult *= 100
    preResult.round(2)
  end

  def generateHTML
    @html = "<div id=\"HTMLtoCodeRatio\">
              <h3>HTML to code ratio:</h3>
              <div id=\"HTMLtoCodeRatioValue\"><p>#{@ratio.to_s}%</p></div>
            </div>"
  end

  def getHtml
    return @html
  end
end