class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :body
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
