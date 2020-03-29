require_relative('../models/Customers')
require_relative('../models/Films')
require_relative('../models/Tickets')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => "Gordon Freeman", 'funds' => 25})
customer1.save()

customer2 = Customer.new({'name' => "Alyx Vance", 'funds' => 15})
customer2.save()

customer3 = Customer.new({'name' => "Barney Calhoun", 'funds' => 30})
customer3.save()

customer4 = Customer.new({'name' => "Isaac Kleiner", 'funds' => 50})
customer4.save()


film1 = Film.new({'title' => "Independence Day", 'price' => 7})
film1.save()

film2 = Film.new({'title' => "Edge of Tomorrow", 'price' => 10})
film2.save()

film3 = Film.new({'title' => "War of the Worlds", 'price' => 5})
film3.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket3.save()

ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film2.id})
ticket4.save()

# film3.title = "The War of the Worlds"
# film3.update_title_by_id("The War of the Worlds")


binding.pry
nil
