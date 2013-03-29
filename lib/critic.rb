class Critic
  def self.find_by(type, criteria)
    query_results = ReviewDB.instance.new(<<-SQL, criteria)
      SELECT *
        FROM critics
       WHERE #{type} = ?
    SQL
    Critic.new(query_results[0])
  end

  def self.by_id(id)
    Critic.find_by('id', id)
  end

  def self.by_screen_name(screen_name)
    Critic.find_by('screen_name', screen_name)
  end

  attr_accessor :screen_name
  attr_reader :id

  def initialize(critic_details)
    @id = critic_details('id')
    @screen_name = critic_details('screen_name')
  end

  def reviews
    RestaurantReview.by_critic(id)
  end

  def average_review_score
    RestaurantReview.average_score_by_critic(id)
  end

  def unreviewed_restaurants
    RestaurantReview.unreviewed_restaurants_by_critic(id)
  end

end

