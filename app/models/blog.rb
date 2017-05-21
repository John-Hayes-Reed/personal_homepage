# @abstract model representing a Blog / Post item meant to inform readers on a
#   particular subject.
class Blog < ApplicationRecord
  include BottledObservable
  default_scope { order(created_at: :desc) }

  has_many :recent_activities, as: :parent

  with_options presence: true do |v|
    v.validates :title, length: { maximum: 50 }
    v.validates :body, length: { maximum: 2000 }
  end
end
