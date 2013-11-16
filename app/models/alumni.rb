class Alumni < User

  has_many :interests, foreign_key: "user_id", dependent: :destroy
  has_many :tags, through: :interests

  has_many :donations, foreign_key: "alum_id", dependent: :destroy
  has_many :projects, through: :donations
end
