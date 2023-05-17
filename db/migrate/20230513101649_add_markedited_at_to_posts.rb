class AddMarkeditedAtToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :edited, :boolean, null:false, default: false
  end
end
