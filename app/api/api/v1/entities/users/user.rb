module API
  module V1
    module Entities
      module Users
          class User < Grape::Entity
            format_with(:integer_timestamps) { |dt| dt.to_datetime.to_i unless dt.nil? }

            expose :id
            expose :email
            expose :first_name
            expose :last_name
            expose :profile_url
            expose :longitude
            expose :latitude
            expose :message

            with_options(format_with: :integer_timestamps) do
              expose :created_at
              expose :updated_at
            end
          end
      end
    end
  end
end
