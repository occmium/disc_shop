# encode: utf-8
# Задача 27-2 — Магазин, заготовка
# Задача 28-1 — Магазин с витриной и конструкторами
# Задача 28-2 — Магазин с сеттерами и update
# Задача 28-3 — Магазин с чтением из файлов
# Задача 28-4 — Магазин с ProductCollection
# Задача 28-5 — Магазин с дисками

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'
require_relative 'lib/disc'
require_relative 'lib/product_collection'

product_collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')

begin
  Product.from_file("./data/books/idiot.txt")
rescue
  puts "NotImplementedError Product.from_file"
end

puts "\nДобро пожаловать!\n\nХотите отсортировать список товаров?" \
  "\n0: по умолчанию" \
  "\n1: по умолчанию в обратном порядке" \
  "\n2: по имени с начала" \
  "\n3: по имени с конца" \
  "\n4: по цене с дешевых" \
  "\n5: по цене с дорогих" \
  "\n6: по остаткам с редких" \
  "\n7: по остаткам с распространенных"
user_input = STDIN.gets.to_i

puts "\nВыбирайте! Что хотите купить:\n\n0: хочу выйти из магазина"
product_collection.sort!(user_input)
product_collection.to_a.each_with_index {|pos, index| puts "#{index + 1}: #{pos}"}

user_choice = STDIN.gets.to_i
basket = []
sum = 0
until user_choice == 0
  if (1..product_collection.to_a.length).include?(user_choice)
    buy = product_collection.to_a[user_choice - 1]
    available = buy.stock - 1
    basket << buy
    sum += buy.price
    buy.stock = available
    product_collection.to_a.delete_at(user_choice - 1) if available < 1
    puts "\nВы выбрали #{buy.w_out_rest}"
    puts "Всего товаров на сумму:  #{sum} руб."
  end

  puts "\nМожет быть Вы хотите ещё что-нибудь купить ?\n0: ничего не хочу, выйти"
  product_collection.to_a.each_with_index {|pos, index| puts "#{index + 1}: #{pos}"}
  user_choice = STDIN.gets.to_i
end

if !basket.empty?
  temp_hash = {}
  basket.each do |instance|
    if temp_hash.key?(instance)
      temp_hash[instance] += 1
    else
      temp_hash[instance] = 1
    end
  end
  for_print = []
  temp_hash.each {|instance, value| for_print << "#{instance.w_out_rest} - #{value}шт"}

  puts "Вы купили: \n\n"
  for_print.each_with_index {|string, index| puts "#{index + 1}.  #{string}"}
  puts "\nС Вас — #{sum} руб. Спасибо за покупки!"
else
  puts "Приходите к нам ещё, после обеда у нас будут новинки!"
end
