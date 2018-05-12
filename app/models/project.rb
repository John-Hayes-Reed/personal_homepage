# @abstract a model representing Projects of work.
class Project < ApplicationRecord
  include BottledObservable

  extend Enumerize
  enumerize :project_type, in: %i[web gem app]
  serialize :technologies, JSON
  TECHNOLOGY_ATTRIBUTES = %i[
    server
    database
    backend
    frontend
    templates
    app
    version_control
    language
    other
  ].freeze
  TECHNOLOGY_ATTRIBUTES.each { |att| send(:attr_accessor, att) }

  has_many :recent_activities, as: :parent

  with_options presence: true do |v|
    v.validates :title
    v.validates :description
    v.validates :project_type, inclusion: { in: %w[web gem app] }
  end

  scope :web_systems, (-> { where(project_type: 'web') })
  scope :mobile_apps, (-> { where(project_type: 'app') })
end
