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

stranka = Page.new("http://www.golfaky.cz/callaway-golfove-micky/161-callaway-mix-a-100ks.html")
analyza = ESeoKeywordAnalyze.new(stranka.getLinksText)
puts analyza.getSeoKeywordAnalyzeHtmlOutput
analyza.getSeoKeywordAnalyzeHtmlOutputToFile

