class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  scope :following_activities, ->ids{where user_id: ids}
end
