class ChangeOpportunities < ActiveRecord::Migration
  def self.up
	drop_table :opportunities
    create_table :opportunities do |t|
      t.string :name
      t.string :status
      t.string :sbustream
      t.string :value
      t.string :daiowner
      t.date :estdescisiondate
      t.string :contacts
      t.references :company
      t.timestamps
    end
  end

  def self.down
	drop_table :opportunities
  end
end