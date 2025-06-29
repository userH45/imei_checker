

require_relative 'docomo_checker'
require_relative 'kddi_checker'
#同じディレクトリのどこもチェックするメソッドの読み込み

puts "IMEIを入力してください"
imei = STDIN.gets&.strip

unless imei&.match(/\A\d{15}\z/)
  puts "IMEIは15桁の数字で入力してください"
  exit 1
end

result_docomo = check_docomo(imei)
puts "ドコモの判定結果: #{result_docomo}" 

result_kddi = check_kddi(imei)
puts "KDDIの判定結果: #{result_kddi}"

# result_softbank = check_softbank(imei)
# puts "ソフトバンクの判定結果: #{result_softbank}"

# result_rakuten = check_rakuten(imei)
# puts "楽天モバイルの判定結果: #{result_rakuten}"

# どこも　　355878451939011 
#　au 359875470949134
## ソフトバンク 355280111137278
#
#