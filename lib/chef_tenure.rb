class ChefTenure
  def self.find_by(type, criteria)
    query_results = ReviewDB.instance.execute(<<-SQL, criteria)
      SELECT *
        FROM cheftenures
       WHERE #{type} = ?
    SQL
    query_results.map { |result| ChefTenure.new(result) }
  end

  def self.by_restaurant(id)
    ChefTenure.find_by("restaurant_id", id)
  end

  def self.by_chef(id)
    ChefTenure.find_by("chef_id", id)
  end

  def self.coworkers(id)
    query_results = ReviewDB.instance.execute(<<-SQL, id)
      SELECT coworkers.*
      FROM cheftenures AS coworkers JOIN (SELECT *
                                            FROM cheftenures
                                           WHERE chef_id = ?) AS chef
                       ON coworkers.restaurant_id = chef.restaurant_id
      WHERE (coworkers.start_date <= chef.end_date OR chef.end_date IS NULL)
        AND (coworkers.end_date IS NULL OR coworkers.end_date >= chef.start_date)
        AND coworkers.chef_id != chef.chef_id
    SQL
  end

  attr_reader :chef_id, :id, :start_date, :end_date, :head_chief
  alias :head_chief? :head_chief

  def initialize(tenure_details)
    @id = tenure_details['id']
    @chef_id = tenure_details['chef_id']
    @start_date = tenure_details['start_date']
    @end_date = tenure_details['end_date']
    @head_chief = tenure_details['head_chief']
  end
end
