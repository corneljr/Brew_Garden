class AddSliderImagesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :slider_images, :string
  end
end
