# encoding: utf-8
# eSeoKeywordAnalyze.rb.rb-a0001 partOf eSeoTool.rb
=begin
  Musí projet všechny slova na stránce
=end

require 'builder'
require 'page_rankr'

class ESeoKeywordAnalyze


  def initialize linkTexts
    @headerWordCount = Hash::new(0)	  
    @link_word_count = Hash::new(0)
    @html = ""
    getKeywordCount linkTexts
    #getHeadersCount headersTexts
  end

  def getKeywordCount linkTexts
    linkTexts.each { |linkText| @link_word_count.store(linkText, @link_word_count[linkText] + 1) }



    tmp = @link_word_count.sort_by { |key,value| value }
    @link_word_count = tmp.reverse



    @link_word_count.each { |link| link[0] = link[0].gsub(/[„,“,"]/,'*')}

  end

  def getLinkWordCount
    return @link_word_count
  end

  def getHeadersCount headersTexts
    headersTexts.each { |headerText| @headerWordCount.store(headerText, @headerWordCount[headerText] + 1)  }

    tmp = @headerWordCount.sort_by { |key,value| value}
    @headerWordCount = tmp.reverse
  end


  def getSeoKeywordAnalyzeHtmlOutput address, domain
    generateHtmlKeywordCountChart
    generateHtmlDomainStats domain
    generateHtmlHeader
    generateHtmlBody address
    generateHtmlKeywordCount
    generateHtmlFooter
  end

  def generateHtmlDomainStats(domain)
    backlinks = PageRankr.backlinks(domain)

    puts "------------------"
    backlinks.each { |a,b| puts "#{a.to_s}: #{b.to_s}" }
  end

  def generateHtmlKeywordCountChart

    #['Mushrooms', 3],

    @graphDataArray = " "

    top10 = @link_word_count.first(10)

    top10.each { |link_word|
      link_word[0].gsub!(/[<br \/>,\n]/, '_')
      @graphDataArray = "#{@graphDataArray}['#{link_word[0].to_s.gsub(/'/,'>')}',#{link_word[1].to_s}],"

    }

    puts "Graph Data Array : \n" + @graphDataArray.to_s
  end

  def getSeoKeywordAnalyzeHtmlOutputToFile
    File.open("./generatedHtml/LinksWordsCountGenerated.html", "w") { |file| file.write(@html) }
  end

  def generateHtmlHeader
    @html += "<!DOCTYPE html>
      <html lang=\"en\">
      <head>
      <meta charset=\"utf-8\" />
      <title>eWorkers SEO Analytics</title>
      <link rel=\"stylesheet\" href=\"analyticszzzz.css\" type=\"text/css\" />


    <script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>
    <script type=\"text/javascript\">
      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');



        data.addRows([
        " + @graphDataArray +
        "
        ]);

        // Set chart options
        var options = {'title':'Počet slov v odkazech',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>



      </head>
    "
  end

  def generateHtmlBody address
    @html += "<body id=\"seoAnalytics\">"
    @html += "<h1>eWorkers SEO Tools</h1><h2>Klicova slova v odkazech vcetne cetnosti</h2><!--Div that will hold the pie chart-->
    #{address}<div id=\"chart_div\"></div>
"
  end

  def generateHtmlKeywordCount
    puts @link_word_count
    builder = Builder::XmlMarkup.new
    columns = ["Link", "Count"]
    builder.table do |table|
      table.tr do |tr|
        columns.each { |col| tr.th(col) }
      end
      @link_word_count.each do |link|
        table.tr do |tr|
          tr.td(link[0])
          tr.td(link[1])
        end
      end
    end

    @html += builder

  end

  def generateHtmlFooter
    @html += "</body></html>"
  end

end
