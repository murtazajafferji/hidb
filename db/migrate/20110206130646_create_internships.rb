class CreateInternships < ActiveRecord::Migration
  def self.up
    create_table :internships do |t|
      #t.string :how
      t.string :semester
      t.string :year
      #t.boolean :credit
      #t.string :course
      t.string :compensation
      t.string :hours
      t.string :industry
      t.string :company_name
      t.string :company_department
      t.string :city
      t.string :state
      t.string :country
      t.string :website
      t.boolean :public_transport
      t.text :supervision
      t.string :supervisor_name
      t.string :supervisor_phone
      t.string :supervisor_email
      t.text :responsibilities
      #t.string :satisfaction_1
      #t.string :satisfaction_2
      #t.string :satisfaction_3
      #t.string :outcome_1
      #t.string :outcome_2
      #t.string :outcome_3
      t.boolean :offer
      #t.text :recommendations
      t.text :review
      t.boolean :approved, :default => false
      t.text :search_string
      
      t.references :user,  :null => false

      t.timestamps
    end
    add_index :internships, :user_id
  end

  def self.down
    drop_table :internships
  end
end
