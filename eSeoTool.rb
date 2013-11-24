# encoding: utf-8
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
#require 'analyzaKlicovychSlovvv'
require 'builder'

#moje soubory
require './Page'
require './eSeoKeywordAnalyze'

url = "http://localhost/seoTest/machacek.htm"

stranka = Page.new("http://www.kscm.cz/")
analyza = ESeoKeywordAnalyze.new(stranka.getLinksText)
puts analyza.getSeoKeywordAnalyzeHtmlOutput
analyza.getSeoKeywordAnalyzeHtmlOutputToFile

puts __ENCODING__
puts '--'
str = 'Příliš žluťoučký kůň'
puts str.encoding.name
puts '--'
asc = str.encode('ISO-8859-2')
puts asc.encoding.name
puts asc
puts '--'


