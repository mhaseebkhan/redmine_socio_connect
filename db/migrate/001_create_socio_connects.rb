class CreateSocioConnects < ActiveRecord::Migration
  def self.up
    create_table :socio_connects do |t|
      t.string   :uid
      t.string   :provider
      t.string   :name
      t.string   :nickname
      t.string   :email
      t.string   :image
      t.integer  :user_id
      t.datetime :created_on
    end
  end

  def self.down
    drop_table :socio_connect
  end
end
