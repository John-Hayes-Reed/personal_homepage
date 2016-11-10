class Project < ApplicationRecord
  extend Enumerize
  enumerize :project_type, in: %i[web gem app]

  with_options presence: true do |v|
    v.validates :title
    v.validates :description
    v.validates :project_type, inclusion: {in: %w[web gem app]}
  end
end
