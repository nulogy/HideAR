module Model
  def self.included(base)
    base.extend ClassMethods
  end

  attr_reader :internal_data

  def initialize internal_data = data_class.new
    if internal_data.kind_of?(Hash)
      @internal_data = data_class.new internal_data
    else
      @internal_data = internal_data
    end
  end

  module ClassMethods
    def set_data_class clazz
      define_method :data_class do
        clazz
      end
    end

    def fields *field_names
      field_names.each do |field_name|
        self.delegate field_name, to: :internal_data
        self.delegate "#{field_name}=", to: :internal_data
      end
    end
  end
end
