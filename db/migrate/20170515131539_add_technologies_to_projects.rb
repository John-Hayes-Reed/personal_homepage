class AddTechnologiesToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :technologies, :text
  end
end
