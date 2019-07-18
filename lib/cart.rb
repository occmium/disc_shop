# encode: utf-8
# Задача 27-2 — Магазин, заготовка
# Задача 28-1 — Магазин с витриной и конструкторами
# Задача 28-2 — Магазин с сеттерами и update
# Задача 28-3 — Магазин с чтением из файлов
# Задача 28-4 — Магазин с ProductCollection
# Задача 28-5 — Магазин с дисками

class Cart
  attr_accessor :list, :sum, :buy

  def initialize(goods)
    @goods = goods.to_a
    @list = {}
    @sum = 0
  end

  def add(choice)
    if (1..@goods.length).include?(choice)
      @buy = @goods[choice - 1]
      available = @buy.stock - 1
      @list[@buy] ||= 0
      @list[@buy] += 1
      @sum += @buy.price
      @buy.stock = available
      @goods.to_a.delete_at(choice - 1) if available < 1
      @buy.w_out_rest
    end
  end

  def to_s
    count = 1
    list = []
    @list.each do |instance, value|
      list << "#{count}. #{instance.w_out_rest} - #{value}шт"
      count += 1
    end
    list.join("\n")
  end
end
