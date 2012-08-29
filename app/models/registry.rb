require 'ostruct'

module Registry
  extend self

  def data_class_for model_class
    mode_to_data_map[model_class] || OpenStruct
  end

  def model_class_for data_class
    res = data_to_model_map[data_class]
    raise "No model class for #{data_class}" unless res
    return res
  end

  def associate model_class, data_class
    mode_to_data_map[model_class] = data_class
    data_to_model_map[data_class] = model_class
  end

  private

  def mode_to_data_map
    @mode_to_data_map ||= {}
  end

  def data_to_model_map
    @data_to_model_map ||= {}
  end
end