class AddEditedAtToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :edited_at, :datetime
  end
end

