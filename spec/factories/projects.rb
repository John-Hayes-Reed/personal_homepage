FactoryGirl.define do
  factory :project do
    title 'Social care insurance system'
    project_type 'web'
    url 'https://www.google.co.uk'
    description 'This is a test description about a project made with a factory'
    technologies server: 'Heroku',
                 database: 'postgresql',
                 backend: 'Ruby, Rails',
                 frontend: 'CSS, SASS',
                 templates: 'SLIM',
                 version_control: 'Git, Github',
                 other: 'RSpec, Factorygirl'
  end
end