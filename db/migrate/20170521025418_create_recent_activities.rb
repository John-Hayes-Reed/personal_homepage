class CreateRecentActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :recent_activities do |t|
      t.string :title
      t.string :comment
      t.json :urls
      t.belongs_to :parent, polymorphic: true

      t.timestamps
    end
  end
end
