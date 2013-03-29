class Restaurant
  def self.find_by(type, criteria)
    query_results = ReviewDB.instance.execute(<<-SQL, criteria)
      SELECT *
        FROM restaurants
       WHERE #{type} = ?
    SQL
    query_results.map { |result| Restaurant.new(result) }
  end
  def self.by_cuisine(cuisine)
    Restaurant.find_by("cuisine", cuisine)
  end
  def self.by_id(id)
    Restaurant.find_by("id", id)
  end
  def self.by_neighborhood(neighborhood)
    Restaurant.find_by("neighborhood", neighborhood)
  end


  attr_reader :id

  def initialize(restaurant_details)
    @id = restaurant_details["id"]
    @neighborhood = restaurant_details["neighborhood"]
    @cuisine = restaurant_details["cuisine"]
  end

  def average_review_score
    RestaurantReview.average_score_by_restaurant(id)
  end

  def reviews
    RestaurantReview.by_restaurant(id)
  end
end