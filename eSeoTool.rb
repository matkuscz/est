# eSeoTool.rb-a0001
=begin
  - SEO Analýza
  - Analýza klíčových slov
  - Pozice ve vyhledávačích
  - Kontrola zpětných odkazů
  - Validace HTML a CSS
  - Ranky a indexy
  - Hledanost frází
  - Odkazy na doménu
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'awesome_print'
#require 'analyzaKlicovychSlov'
require 'builder'

#moje soubory
require './Page'
require './eSeoKeywordAnalyze'

url = "http://localhost/seoTest/machacek.htm"


#====Reseni v mainu====
#stranka = Nokogiri::HTML(open(url))


#odkazy = stranka.css('a').each { |a|
# text = a.text
# text = text.to_s
# text.strip!
# puts text
#}

#puts stranka.inspect


#====Objektove reseni====

stranka = Page.new("http://localhost/seoTest/machacek.htm")
analyza = ESeoKeywordAnalyze.new(stranka.getLinksText)
puts "Analyza : "
puts analyza.getLinkWordCount
puts "Html output"
puts analyza.getSeoKeywordAnalyzeHtmlOutput
puts "AAAAAAAAAAAAAAAAA"

analyza.getSeoKeywordAnalyzeHtmlOutputToFile

#puts analyza

#puts stranka.getLinksText

#puts stranka.link_word_count

#a = [{"col1" => "val1", "col2" => "val2"}, {"col1" => "val3", "col2" => "val4"}]

a = stranka.getLinkWordCount
puts a
puts a.class

puts "______"


builder = Builder::XmlMarkup.new
columns = ["Link", "Count"]
builder.table do |table|
  table.tr do |tr|
    columns.each { |col| tr.th(col) }
  end
  a.each do |zaznam|
    table.tr do |tr|
     tr.td(zaznam[0])
     tr.td(zaznam[1])
    end
  end
end


p builder.target


a = { "q" => 5, "w"=> 6, "e" => 1 }
#a.sort_by { |name,value| value }
ao = {}

#a.values.sort.each { |key, value|
#  puts key
#  puts value
#}

a.keys.sort.reverse.each { |k|
  ao[k] = a[k]
}

puts ao

#@link_word_count.sort_by { |word, count| count }



#builder = Nokogiri::HTML::Builder.new do |doc|
#doc.html {
#  doc.body(:onload => 'some_func();') {
#    doc.h1 {
#      doc.text "Počet výskytů odkazů na stránce:"
#    }
#    doc.p("Tady mame vysledky:")
#  }
#}
#end
#puts builder.to_html


#puts page
#link_titles = page.html("p")
#puts link_titles.inspect


#acka = bodyHTML.css('a.woahbar-link').text


#puts acka.inspect


#puts bodyHTML
