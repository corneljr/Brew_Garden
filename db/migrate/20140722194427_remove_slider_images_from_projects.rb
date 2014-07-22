class RemoveSliderImagesFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :slider_images
  end
end
