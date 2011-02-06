class InfoController < ApplicationController
  def terms
  end
  
  def about
  end
  
  def privacy
  end
  
  def contact
  end
  
  def resume
  end
  
  def index
    @events_today = Event.today(current_user)
    @events_previous = Event.previous(current_user, 1)
    @events_next = Event.next(current_user, 5)
    @ayat = Quran.random_ayat
    
    if current_user
      @trackings = current_user.trackings - current_user.upcoming_trackings
    end
  end
  
  def monthly
  end
  
  def test
  end
  
end