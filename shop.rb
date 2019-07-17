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
require_relative 'lib/cart'

product_collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
cart = Cart.new

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

until user_choice == 0
  cart.add(user_choice, product_collection)
  puts "\nВы выбрали #{cart.buy}\nВсего товаров на сумму:  #{cart.sum} руб."
  puts "\nМожет быть Вы хотите ещё что-нибудь купить ?\n0: ничего не хочу, выйти"
  product_collection.to_a.each_with_index {|pos, index| puts "#{index + 1}: #{pos}"}
  user_choice = STDIN.gets.to_i
end

if cart.list.empty?
  puts "Приходите к нам ещё, после обеда у нас будут новинки!"
else
  puts "Вы купили: \n\n"
  cart.to_print
  puts "\nС Вас — #{cart.sum} руб. Спасибо за покупки!"
end
