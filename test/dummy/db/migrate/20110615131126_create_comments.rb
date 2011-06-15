class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title
      t.string :article

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
