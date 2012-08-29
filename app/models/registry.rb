require 'ostruct'

module Registry
  extend self

  def data_class_for model_class
    map[model_class] || OpenStruct
  end

  def associate model_class, data_class
    map[model_class] = data_class
  end

  private

  def map
    @map ||= {}
  end
end