# encode: utf-8
# Задача 27-2 — Магазин, заготовка
# Задача 28-1 — Магазин с витриной и конструкторами
# Задача 28-2 — Магазин с сеттерами и update
# Задача 28-3 — Магазин с чтением из файлов
# Задача 28-4 — Магазин с ProductCollection
# Задача 28-5 — Магазин с дисками

class Disc < Product
  attr_accessor :name, :implementer, :genre, :year

  def self.from_file(current_file)
    sim_array = File.readlines(current_file, encoding: "UTF-8", chomp: true)

    self.new(:name => sim_array[0].to_s,
             :implementer => sim_array[1].to_s,
             :genre => sim_array[2].to_s,
             :year => sim_array[3].to_i,
             :price => sim_array[4].to_i,
             :stock => sim_array[5].to_i
    )
  end

  def initialize(parameters)
    super

    @name = parameters[:name]
    @implementer = parameters[:implementer]
    @genre = parameters[:genre]
    @year = parameters[:year]
  end

  def to_s
    "Альбом #{implementer}, «#{name}», жанр #{genre}, #{year}, #{super}"
  end

  def w_out_rest
    "Альбом #{implementer}, «#{name}», жанр #{genre}, #{year}, #{super}"
  end

  def update(parameters)
    super

    @name = parameters[:name] if parameters[:name]
    @implementer = parameters[:implementer] if parameters[:implementer]
    @genre = parameters[:genre] if parameters[:genre]
    @year = parameters[:year] if parameters[:year]
  end
end
