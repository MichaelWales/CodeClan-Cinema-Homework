require_relative('../db/sql_runner')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  ## [SAVE], [UPDATE BY ID], [ALL], FIND BY ID, DELETE, [DELETE ALL]

  def save()
    sql = "INSERT INTO customers
    (name, funds)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql, [])
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql, [])
    result = customers.map { |customer| Customers.new( customer ) }
    return result
  end

  def update()
    sql = "UPDATE customers SET
    (name,funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer_hash = SqlRunner.run(sql,values).first()
    return nil if customer_hash == nil
    return Customer.new(customer_hash)
  end

  def films()
    sql = "SELECT films.*  FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map {|film_hash| Film.new(film_hash)}
  end

end
