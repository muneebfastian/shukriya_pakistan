module API
  module V1
    class Root < Grape::API
      # Setting defaults
      version   'v1'
      format :json

      # Mounting Registration API
      mount API::V1::Users
    end
  end
end
