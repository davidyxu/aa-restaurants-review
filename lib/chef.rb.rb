class Chef
  def self.find_by_id(id)
    query_results = ReviewDB.instance.execute(<<-SQL, id)
      SELECT *
        FROM chef
       WHERE id = ?
    SQL
    Chef.new(query_results[0])
  end
  def self.find_by_name(first_name, last_name)
    query_results = ReviewDB.instance.execute(<<-SQL, first_name, last_name)
      SELECT *
        FROM chef
       WHERE first_name = ?, last_name = ?
    SQL
    Chef.new(query_results[0])
  end

	attr_accessor :first_name :last_name :mentor
	attr_reader :id

  def initialize(chef_details)
    @first_name = chef_details["first_name"]
    @last_name = chef_details["last_name"]
    @id = chef_details["id"]
    @mentor = chef_details["mentor"]
  end

	def mentor
    return nil if mentor.nil?
    find_by_id(mentor)
	end

	def name
    "#{first_name} #{last_name}"
	end

	def tenures
    ChefTenure.find_by_chef(id)
	end
end

class Restaurant

end

class ChefTenure

end

class Critic

end

class Restaurant Review

end