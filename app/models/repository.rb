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
    res = model._data
    if res.kind_of? OpenStruct
      res = data_class.new res.marshal_dump
    end
    model._data = res
    res
  end

  def set_data_class clazz
    singleton_class.send :define_method, :data_class do
      clazz
    end
  end

  def set_model_class clazz
    singleton_class.send :define_method, :model_class do
      clazz
    end
  end
end