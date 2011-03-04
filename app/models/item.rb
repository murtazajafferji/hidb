class Item < ActiveRecord::Base
  after_create :assign_number
  
  def assign_number
    self.number = Item.find(:all, :conditions => {:collection => collection}).size if collection
    save(false)
  end
  
  def self.collection_names
    Item.all.collect{|x| x.collection}.uniq
  end
  
  def self.separated_by_collection
    array = collection_names.collect{|x| Item.find(:all, :conditions => {:collection => x}, :order => :number)}.sort{|a,b| a.length <=> b.length}
  end
end
