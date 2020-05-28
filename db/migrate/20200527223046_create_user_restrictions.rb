class CreateUserRestrictions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_restrictions do |t|
      t.references :user, foreign_key: true
      t.references :restriction, foreign_key: true
      t.timestamps
    end
  end
end
