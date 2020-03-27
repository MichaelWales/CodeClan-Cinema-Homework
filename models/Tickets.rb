require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (customer_id, film_id)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql, [])
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql, [])
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    ticket_hash = SqlRunner.run(sql,values).first()
    return nil if ticket_hash == nil
    return Ticket.new(ticket_hash)
  end

end
