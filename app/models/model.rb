require 'ostruct'

module Model
  def self.included(base)
    base.extend ClassMethods
  end

  attr_accessor :_data

  def initialize _data = OpenStruct.new
    if _data.kind_of?(Hash)
      @_data = OpenStruct.new _data
    else
      @_data = _data
    end
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
