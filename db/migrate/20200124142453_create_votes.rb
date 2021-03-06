class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :link, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
      t.index [:link_id, :user_id], unique: true
    end
  end
end
