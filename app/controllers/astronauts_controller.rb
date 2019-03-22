class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all
    @avg_age = @astronauts.average_age
  end
end
