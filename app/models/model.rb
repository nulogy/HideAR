require 'ostruct'

module Model
  def self.included(base)
    base.extend ClassMethods
  end

  attr_accessor :_data

  def initialize _data = _new_instance
    if _data.kind_of?(Hash)
      @_data = _new_instance _data
    else
      @_data = _data
    end
  end

  protected

  def wrap collection
    return [] if collection.empty?
    model_class = Registry.model_class_for(collection.first.class)
    collection.map{|c| model_class.new c}
  end

  private

  def _new_instance hash = {}
    Registry.data_class_for(self.class).new hash
  end

  module ClassMethods
    def fields *field_names
      field_names.each do |field_name|
        self.delegate field_name, to: :_data
        self.delegate "#{field_name}=", to: :_data
      end
    end
  end
end
