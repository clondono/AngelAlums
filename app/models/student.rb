class Student < User
  has_many :projects, foreign_key: "owner_id", dependent: :destroy


  has_many :collaborations, foreign_key: "user_id", dependent: :destroy
  has_many :shared_projects, class_name: "Project", through: :collaborations
  
end
