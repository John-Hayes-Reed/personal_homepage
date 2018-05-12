# Base superclass for models in the project.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
