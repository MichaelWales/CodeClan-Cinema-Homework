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

  def update_funds_by_id(id)
    sql = "UPDATE customers SET funds = $1 WHERE id = $2"
    values = [@funds, id]
    SqlRunner.run(sql,values)
  end

  def update_name_by_id(id)
    sql = "UPDATE customers SET name = $1 WHERE id = $2"
    values = [@name, id]
    SqlRunner.run(sql,values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer_hash = SqlRunner.run(sql,values).first()
    return nil if customer_hash == nil
    return Customer.new(customer_hash)
  end

end
