class Interests < ActiveRecord::Base
  
  belongs_to :alumni, foreign_key: 'user_id'
  belongs_to :tag
end
