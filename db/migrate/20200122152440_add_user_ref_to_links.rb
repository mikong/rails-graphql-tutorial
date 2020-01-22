class AddUserRefToLinks < ActiveRecord::Migration[6.0]
  def change
    add_reference :links, :user, null: false, foreign_key: true
  end
end
