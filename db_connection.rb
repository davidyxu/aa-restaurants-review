require 'singleton'
require 'sqlite3'

class ReviewDB < SQLite3::Database
  include Singleton

  def initialize
    super("../db/restaurants.db")
    self.results_as_hash = true
    self.type_translation = true
  end
end

