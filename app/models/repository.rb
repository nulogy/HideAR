require 'ostruct'

module Repository
  def persist model
    data(model).save!
  end

  def find id
    data_class.find id
  end

  def where attrs
    data_class.where attrs
  end

  def data model
    model._data
  end

  def set_model_class model_class, options
    raise "Data class is not provided" unless options[:for]

    Registry.associate(model_class, options[:for])

    if options[:root]
      singleton_class.send :define_method, :data_class do
        options[:for]
      end

      singleton_class.send :define_method, :model_class do
        model_class
      end
    end
  end
end