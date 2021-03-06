require 'ostruct'

module Spawner
  def spawner &default
    @@spawn ||= Hash.new
    @@spawn[self.name] = default
  end

  def spawn attrs = {}
    @@spawn[self.name].call(model = OpenStruct.new)
    factory_method = respond_to?(:create!) ? :create! : :create
    send(factory_method, model.send(:table).merge(attrs))
  end
end
