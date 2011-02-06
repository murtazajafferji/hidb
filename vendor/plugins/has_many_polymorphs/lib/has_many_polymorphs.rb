require 'active_record'
require 'has_many_polymorphs/reflection'
require 'has_many_polymorphs/association'
require 'has_many_polymorphs/class_methods'

require 'has_many_polymorphs/support_methods'
require 'has_many_polymorphs/base'

class ActiveRecord::Base
  extend ActiveRecord::Associations::PolymorphicClassMethods
end

if ENV['HMP_DEBUG'] && (Rails.env.development? || Rails.env.test?)
  require 'has_many_polymorphs/debugging_tools'
end

require 'has_many_polymorphs/railtie'

_logger_debug "loaded ok"
