class CreateOpportunities < ActiveRecord::Migration
  def self.up
    create_table :opportunities do |t|

      t.string :name

      t.string :status

      t.string :sbustream

      t.string :value

      t.string :daiowner

      t.date :estdescisiondate

      t.string :companyname

      t.string :contacts


      t.timestamps

    end
  end

  def self.down
    drop_table :opportunities
  end
end
