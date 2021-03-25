require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    class_name.constantize
  end

  def table_name
    # ...
    down = class_name.downcase
    down == "human" ? "humans" : down.pluralize
    # class_name.downcase.pluralize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    defaults = {
      foreign_key: (name.to_s.downcase + "_id").to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end

    
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    defaults = {
      foreign_key: (self_class_name.to_s.downcase + "_id").to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase.singularize
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    
    define_method(name) {
      belong = BelongsToOptions.new(name, options)
      belong.model_class.where(belong.primary_key => self.send(belong.foreign_key)).first
    }
  end

  def has_many(name, options = {})
    # ...
    define_method(name) {
      hasm = HasManyOptions.new(name, self.class.to_s, options)
      hasm.model_class.where(hasm.foreign_key => self.id)
    }
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
