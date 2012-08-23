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
    model.internal_data
  end

  def set_data_class clazz
    singleton_class.send :define_method, :data_class do
      clazz
    end
  end
end