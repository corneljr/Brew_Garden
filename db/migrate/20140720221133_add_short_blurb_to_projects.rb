class AddShortBlurbToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :short_blurb, :string
  end
end
