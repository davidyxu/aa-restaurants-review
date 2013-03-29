class RestaurantReview
  def self.find_by(type, criteria)
    query_results = ReviewDB.instance.execute(<<-SQL, criteria)
      SELECT *
        FROM restaurantreviews
       WHERE #{type} = ?
    SQL

    query_results.map { |result| RestaurantReview.new(result) }
  end

  def self.by_restaurant(id)
    RestaurantReview.find_by('restaurant_id', id)
  end

  def self.by_critic(id)
    RestaurantReview.find_by('critic_id', id)
  end

  def self.by_head_chef(id)
    query_results = ReviewDB.instance.execute(<<-SQL, id)
    SELECT reviews.*
      FROM restaurantreviews AS reviews JOIN
                  (SELECT restaurant_id, start_date, end_date
                     FROM cheftenures
                    WHERE head_chief = 1 AND chef_id = ?) AS headchef_tenures
                       ON reviews.restaurant_id = headchef_tenures.restaurant_id
     WHERE reviews.review_date >= headchef_tenures.start_date
       AND (reviews.review_date <= headchef_tenures.end_date
        OR headchef_tenures.end_date IS NULL)
    SQL

    query_results.map { |result| RestaurantReview.new(result) }
  end

  def self.at_least_n_reviews(n)
    query_results = ReviewDB.instance.execute(<<-SQL, n)
      SELECT restaurant_id
        FROM restaurantreviews
    GROUP BY restaurant_id
      HAVING COUNT(*) >= ?
    ORDER BY COUNT(*) DESC
    SQL

    query_results.map { |result| Restaurant.by_id(result['restaurant_id'])}
  end

  def self.top_rated(n)
    query_results = ReviewDB.instance.execute(<<-SQL)[0...n]
      SELECT restaurant_id
        FROM restaurantreviews
    GROUP BY restaurant_id
    ORDER BY AVG(score) DESC
    SQL

    query_results.map { |result| Restaurant.by_id(result['restaurant_id'])}
  end

  def self.average_score_by(type, criteria)
    query_results = ReviewDB.instance.execute(<<-SQL, criteria)
      SELECT AVG(score) AS avg_score
        FROM restaurantreviews
       WHERE #{type} = ?
    SQL

    query_results[0]["avg_score"]
  end

  def self.average_score_by_restaurant(id)
    RestaurantReview.average_score_by('restaurant_id', id)
  end

  def self.average_score_by_critic(id)
    RestaurantReview.average_score_by('critic_id', id)
  end

  def self.unreviewed_restaurants_by_critic(id)
    query_results = ReviewDB.instance.execute(<<-SQL, id)
      SELECT restaurants.*
        FROM restaurants LEFT JOIN (SELECT DISTINCT restaurant_id
                                      FROM restaurantreviews
                                     WHERE critic_id = ?) AS reviewed
                                ON restaurants.id = reviewed.restaurant_id
       WHERE reviewed.restaurant_id IS NULL
    SQL

    query_results.map { |result| Restaurant.new(result) }
  end

  attr_accessor :text_review, :score
  attr_reader :id, :restaurant_id, :critic_id, :review_date

  def initialize(review_details)
    @id = review_details['id']
    @restaurant_id = review_details['restaurant_id']
    @critic_id = review_details['critic_id']
    @text_review = review_details['text_review']
    @score = review_details['score']
    @review_date = review_details['review_date']
  end
end