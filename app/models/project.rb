class Project < ApplicationRecord
  extend Enumerize
  enumerize :project_type, in: %i[web gem app]
  serialize :technologies, JSON

  attr_accessor :server,
                :database,
                :backend,
                :frontend,
                :templates,
                :app,
                :version_control,
                :language,
                :other

  after_initialize :init_technologies

  before_validation :input_technologies

  with_options presence: true do |v|
    v.validates :title
    v.validates :description
    v.validates :project_type, inclusion: {in: %w[web gem app]}
  end

  private

  def init_technologies
    self.technologies ||= {}
    %i[server database backend frontend templates app version_control language other].each do |tech|
      instance_variable_set :"@#{tech}", technologies[tech.to_s]
      instance_variable_set :"@#{tech}", nil if technologies[tech.to_s].blank?
    end
  end

  def input_technologies
    self.technologies ||= {}
    %i[server database backend frontend templates app version_control language other].each do |tech|
      self.technologies[:"#{tech}"] = send(:"#{tech}")
    end
  end
end
