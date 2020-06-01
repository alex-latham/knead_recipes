class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string, default: 'https://i.kym-cdn.com/photos/images/newsfeed/001/076/734/879.jpg'
  end
end
