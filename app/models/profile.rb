module Profile
  def self.included(base)
    base.class_eval do
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    
    def facebook
      if token = authenticated_with?(:facebook)
        @facebook ||= JSON.parse(token.get("/me"))
      end
    end
    
    # def twitter
    #   if token = authenticated_with?(:twitter)
    #     @twitter ||= JSON.parse(token.get("/account/verify_credentials.json").body)
    #   end
    # end

    def google
      if token = authenticated_with?(:google)
        @google ||= get_token(:google) # todo
      end
    end
    
    # primitive profile to show what's possible
    def profile
      unless @profile
        @profile = if facebook
          {
            :id     => facebook["id"],
            :name   => facebook["name"],
            :photo  => "https://graph.facebook.com/#{facebook["id"]}/picture",
            :link   => facebook["link"],
            :title  => "Facebook"
          }
        elsif google
          {
            :id     => "unknown",
            :name   => google.key.slice(/.*?@/).chop,
            :photo  => "/images/icons/google.png",
            :link   => "/images/icons/google.png",
            :title  => "Google"
          }
        # elsif twitter
        #   {
        #     :id     => twitter["id"],
        #     :name   => twitter["name"],
        #     :photo  => twitter["profile_image_url"],
        #     :link   => "http://twitter.com/#{twitter["screen_name"]}",
        #     :title  => "Twitter"
        #   }
        else
          {
            :id     => id,
            :name   => username,
            :photo  => "/images/icons/no-image.png",
            :link   => "/images/icons/no-image.png",
            :title  => "Amal Tracker"
          }
        end
      end

      @profile
    end
    
  end
  
end