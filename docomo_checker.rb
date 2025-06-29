
require 'mechanize'
require 'nokogiri'

def check_docomo(imei)
  agent = Mechanize.new
  top = agent.get('http://nw-restriction.nttdocomo.co.jp/top.php')
  next_page = top.link_with(text: /ネットワーク利用制限の確認/)&.click 
  return "次のページへの遷移に失敗しました" unless next_page
  
  form = next_page.form_with(action:/search\.php/)
  return "IMEI入力フォームが見つかりません" unless form  #ここでserch.php 
  
  form.field_with(name: 'productno').value = imei
  result_page = form.submit 

  #ここまでがimeiの入力とtoppegaからresultページまでの遷移、ここからがnokogiriでresutlpageでの取得
  
  html = Nokogiri::HTML(result_page.body)
  result_docomo = html.css('div.result-panel')[1]&.text&.strip
  if result_docomo.nil?
    '判定が取得できませんでした'
  elsif result_docomo.empty?
    '判定が取得できませんでした'
  else
    result_docomo
  end
end
