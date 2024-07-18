class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :discount
      t.datetime :expiry_date
      t.integer :usage_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
