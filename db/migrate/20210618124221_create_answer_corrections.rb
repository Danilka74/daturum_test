class CreateAnswerCorrections < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_corrections do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
