class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do | t |
      t.belongs_to :user

      t.datetime :date, null: false
      t.string :category
      t.string :notes

      t.boolean :attended, default: nil
      t.boolean :paid, default: nil
    end
  end
end
