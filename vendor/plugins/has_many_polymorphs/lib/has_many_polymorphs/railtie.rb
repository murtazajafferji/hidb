module HasManyPolymorphs
  class Railtie < Rails::Railtie
    initializer "has_many_polymorphs" do |app|
      require 'has_many_polymorphs/autoload'
      HasManyPolymorphs.setup
    end
  end
end