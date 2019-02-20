class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 24 },
            uniqueness: { case_sensitive: false }
end
