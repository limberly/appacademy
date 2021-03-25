require_relative '02_searchable'
require 'active_support/inflector'

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
      foreign_key: (name.downcase + "_id").to_sym,
      primary_key: :id,
      class_name: name.camelcase
    }

    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end

    
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end
