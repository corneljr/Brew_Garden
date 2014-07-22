class CreateSliderImages < ActiveRecord::Migration
  def change
    create_table :slider_images do |t|
      t.integer :project_id
      t.string :slider_image

      t.timestamps
    end
  end
end
