class String 
  # capitalizes every word in the string
  def capitalizer
    self.split(' ').map {|w| w.capitalize }.join(' ')
  end
    
end