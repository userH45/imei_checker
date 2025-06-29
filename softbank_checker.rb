
require 'Mechanize'
require 'nokogiri'

def check_softbank(imei)
  
  agent = Mechanize.new 
  top = agent.get('https://ct99.my.softbank.jp/WBF/icv')
  form = top.form_with(action: /WBF\/icv/)
  return "IMEI入力フォームが見つかりません" unless form

  form.field_with(name: 'imei').value = imei #IMEIを入力
  result_page = form.submit

  html = Nokogiri::HTML(result_page.body)
  result_text = html.css('font[size=8][color="#666666"]')&.text&.strip

  result_softbank = result_text 
  if result_softbank.nil?
    '判定が取得できませんでした'
  elsif result_softbank.empty?
    '判定が取得できませんでした'
  else
    result_softbank
  end

end