class AddSchoolToInternshipsAndUsers < ActiveRecord::Migration
  def self.up
    add_column :internships, :school, :string
    add_column :users, :school, :string
  end

  def self.down
    remove_column :internships, :school
    remove_column :users, :school    
  end
end
