class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :reporter_id
      t.integer :reported_id
      t.text :reason
      t.integer :status

      t.timestamps
    end
  end
end
