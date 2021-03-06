class CommunityMembership < ApplicationRecord
  enum role: { member: 0, moderator: 1, admin: 2 }

  belongs_to :user, foreign_key: "user_id"
  belongs_to :community, foreign_key: "community_id"

  validates_presence_of :user_id, :community_id

end
