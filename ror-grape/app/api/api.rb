require 'v1/bycyclev1.rb'


module API

  class Base < Grape::API

    mount API::BycycleV1

  end

end