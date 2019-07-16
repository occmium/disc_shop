# encode: utf-8
# Задача 27-2 — Магазин, заготовка
# Задача 28-1 — Магазин с витриной и конструкторами
# Задача 28-2 — Магазин с сеттерами и update
# Задача 28-3 — Магазин с чтением из файлов
# Задача 28-4 — Магазин с ProductCollection
# Задача 28-5 — Магазин с дисками

class Product
  attr_accessor :stock, :price

  def initialize(parameters)
    @price = parameters[:price]
    @stock = parameters[:stock]
  end

  def to_s
    if @stock == 1
      "#{@price} руб. (витринный экземпляр)"
    else
      "#{@price} руб. (осталось #{@stock})"
    end
  end

  def w_out_rest
    "#{@price} руб."
  end

  def update(parameters)
    @price = parameters[:price] if parameters[:price]
    @stock = parameters[:stock] if parameters[:stock]
  end

  def self.from_file(current_file)
    raise
  end
end
