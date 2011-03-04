class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string    :login,               :null => true,  :limit => 40
      t.string    :email,               :null => true,  :limit => 100 # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => true                 # optional, see below
      t.string    :password_salt,       :null => true                 # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      
      # authlogic-connect
      t.integer :active_token_id
      
      t.string    :url
      t.string    :name
      t.boolean   :admin, :default => false
      t.boolean   :super, :default => false
      
      t.string    :first_name
      t.string    :last_name
      t.string    :email
      t.string    :major
      t.string    :minor
      t.string    :yog
      
      t.timestamps
    end
    
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :last_request_at
    add_index :users, :active_token_id
  end

  def self.down
    drop_table "users"
  end
end
