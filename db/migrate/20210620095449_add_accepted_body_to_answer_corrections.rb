class AddAcceptedBodyToAnswerCorrections < ActiveRecord::Migration[6.1]
  def change
    add_column :answer_corrections, :accepted_body, :text
  end
end
