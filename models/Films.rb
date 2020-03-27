require_relative('../db/sql_runner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@title, @price]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql, [])
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql, [])
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def update_title_by_id(id)
    sql = "UPDATE films SET title = $1 WHERE id = $2"
    values = [@title, id]
    SqlRunner.run(sql,values)
  end

  def update_price_by_id(id)
    sql = "UPDATE films SET price = $1 WHERE id = $2"
    values = [@price, id]
    SqlRunner.run(sql,values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    film_hash = SqlRunner.run(sql,values).first()
    return nil if film_hash == nil
    return Film.new(film_hash)
  end

end
