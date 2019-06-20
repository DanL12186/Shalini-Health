class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name

      t.string :cell
      t.string :home_phone
      t.string :email
      
      t.string :password_digest

      t.text :patient_notes

      t.integer :past_appointments_count
      t.integer :appointments_missed
      t.integer :appointments_canceled

      t.timestamps
    end
  end
end
