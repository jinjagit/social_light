class User < ApplicationRecord
  has_many :events, class_name: 'Event', foreign_key: 'creator_id'

  validates :name, presence: true, length: { maximum: 24 },
            uniqueness: { case_sensitive: false }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
