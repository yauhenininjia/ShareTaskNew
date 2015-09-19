class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.boolean :answered

      t.timestamps null: false
    end
  end
end
