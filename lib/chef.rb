class Chef
  def self.find_by_id(id)
    query_results = ReviewDB.instance.execute(<<-SQL, id)
      SELECT *
        FROM chefs
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

	attr_accessor :first_name, :last_name, :mentor_id
	attr_reader :id

  def initialize(chef_details)
    @first_name = chef_details["first_name"]
    @last_name = chef_details["last_name"]
    @id = chef_details["id"]
    @mentor_id = chef_details["mentor_id"]
  end

	def mentor
    return nil if mentor_id.nil?
    Chef.find_by_id(mentor_id)
	end

	def name
    "#{first_name} #{last_name}"
	end

	def tenures
    ChefTenure.find_by_chef(id)
	end

  def protoges
    query_results = ReviewDB.instance.execute(<<-SQL, id)
      SELECT *
        FROM chefs
       WHERE mentor_id = ?
    SQL
    query_results.map { |result| Chef.new(result) }
  end

  def num_protoges
    query_results = ReviewDB.instance.execute(<<-SQL, id)
      SELECT COUNT(*) AS protoges
        FROM chefs
       WHERE mentor_id = ?
    SQL
    query_results[0]["protoges"]
  end
end