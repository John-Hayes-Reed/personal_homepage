# @abstract A model to represent any recent activity that has taken place within
#   the webpage.
class RecentActivity < ApplicationRecord
  serialize :urls, JSON
  belongs_to :parent, polymorphic: true

  with_options presence: true do |v|
    v.validates :title, length: { maximum: 20 }
    v.validates :comment, length: { maximum: 30 }
  end
end
