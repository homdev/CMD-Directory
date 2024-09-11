class AddBannerImageMetadataToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :banner_image_metadata, :text
  end
end
