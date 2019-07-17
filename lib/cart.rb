# encode: utf-8
# Задача 27-2 — Магазин, заготовка
# Задача 28-1 — Магазин с витриной и конструкторами
# Задача 28-2 — Магазин с сеттерами и update
# Задача 28-3 — Магазин с чтением из файлов
# Задача 28-4 — Магазин с ProductCollection
# Задача 28-5 — Магазин с дисками

class Cart
  attr_accessor :list, :sum, :buy

  def initialize
    @list = {}
    @sum = 0
  end

  def add(choice, assortment)
    if (1..assortment.to_a.length).include?(choice)
      @buy = assortment.to_a[choice - 1]
      available = @buy.stock - 1
      if @list.key?(@buy)
        @list[@buy] += 1
      else
        @list[@buy] = 1
      end
      @sum += @buy.price
      @buy.stock = available
      assortment.to_a.delete_at(choice - 1) if available < 1
      @buy.w_out_rest
    end
  end

  def to_print
    count = 1
    @list.each do |instance, value|
      puts "#{count}. #{instance.w_out_rest} - #{value}шт"
      count += 1
    end
  end
end
