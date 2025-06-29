
require 'mechanize'
require 'nokogiri'

def check_kddi(imei)
  agent = Mechanize.new 
  top = agent.get('https://my.au.com/cmn/WCV009001/WCE009001.hc?_gl=1*1f15uho*_ga*MTc0OTMzNzM3My4xNzUxMDAzMjA1*_ga_NEDL1XGXY7*czE3NTExNjQxNzYkbzMkZzAkdDE3NTExNjQxNzYkajYwJGwwJGgw')
  form = top.form_with(action:/WCE009002\.hc/)
  return "IMEI入力フォームが見つかりません" unless form

  form.field_with(name: 'imei').value = imei #imeiを入力
  result_page = form.submit 
  #ここまでがimeiの入力とtoppegaからresultページまでの遷移、ここからがnokogiriでresutlpageでの取得
  
  html = Nokogiri::HTML(result_page.body)
  
  
  result_text = html.css('li.list_item:nth-of-type(2) div.list_details').text.strip 
  #説明文を全部取得

  # result_kddi = result_text[/[×△○－]:/, 0]&.chr
  #IMEI番号の後に最初に出力される記号を取得
  # puts result_text
  result_kddi = result_text[0] #最初の文字を取得
  
    if result_kddi.nil?
    '判定が取得できませんでした'
  elsif result_kddi.empty?
    '判定が取得できませんでした'
  else
    result_kddi
  end
end