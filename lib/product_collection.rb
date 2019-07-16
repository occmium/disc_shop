# encode: utf-8
# Задача 27-2 — Магазин, заготовка
# Задача 28-1 — Магазин с витриной и конструкторами
# Задача 28-2 — Магазин с сеттерами и update
# Задача 28-3 — Магазин с чтением из файлов
# Задача 28-4 — Магазин с ProductCollection
# Задача 28-5 — Магазин с дисками

class ProductCollection
  attr_accessor :by, :order

  GOODS_FROM_DATA = {
    :book => {dir: 'books', class: Book},
    :movie => {dir: 'films', class: Movie},
    :disc => {dir: 'cds', class: Disc}
  }

  def self.from_dir(current_dir)
    collection = []

    GOODS_FROM_DATA.each_value do |each_class|
      product_path = '/' + each_class[:dir] + '/*.txt'
      product_class = each_class[:class]
      Dir[current_dir + product_path].each do |each_dir|
        if product_class.from_file(each_dir).stock > 0 # нулевые остатки  не рассматриваем вообще
          collection << product_class.from_file(each_dir)
        end
      end
    end

    self.new(collection)
  end

  def initialize(array = [])
    @collection = array
    @sort_options_hash = {:by => by, :order => order}
  end

  def to_a
    @collection
  end

  def sort!(variable)
    case variable
    when 1
      @sort_options_hash[:order] = :descending
    when 2
      @sort_options_hash[:by] = :name
    when 3
      @sort_options_hash[:by] = :name
      @sort_options_hash[:order] = :descending
    when 4
      @sort_options_hash[:by] = :price
    when 5
      @sort_options_hash[:by] = :price
      @sort_options_hash[:order] = :descending
    when 6
      @sort_options_hash[:by] = :stock
    when 7
      @sort_options_hash[:by] = :stock
      @sort_options_hash[:order] = :descending
    else
      return
    end

    if @sort_options_hash[:by] == :name
      @collection.sort_by! {|one| one.name.to_s}
    elsif @sort_options_hash[:by] == :price
      @collection.sort_by! {|one| one.price.to_i}
    elsif @sort_options_hash[:by] == :stock
      @collection.sort_by! {|one| one.stock.to_i}
    end

    if @sort_options_hash[:order] == :descending
      @collection.reverse!
    end

    self
  end
end
