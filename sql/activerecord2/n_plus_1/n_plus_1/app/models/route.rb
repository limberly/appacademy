class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # TODO: your code here
    info = self.buses.joins(:drivers).select("drivers.name, drivers.bus_id")
    all_drivers = Hash.new {|h, k| h[k] = Array.new}
    info.each do |bus|
      all_drivers[bus.bus_id] << bus.name
    end
    all_drivers
  end
end
