module API
  class Root < Grape::API
    prefix 		'api'
    
    # Mounting the V1 of API
    mount API::V1::Root

    # Adding swagger documentation
    add_swagger_documentation api_version: 'v1'
  end
end