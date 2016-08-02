module API
	module V1
		class Users < Grape::API
			# include API::V1::Authentication

			resource :users do
				# ================== API to search the users of the system ==================
				desc 'Returns all users'
				params do
					# requires :access_token, type: String, desc: "Access Token for authentication"
				end
				get 'all_users' do
					users = User.all
					users_with_entities = API::V1::Entities::Users::User.represent(users)

      		return {
            code: '200', status: 'ok' , data: {users: users_with_entities}
          }
				end

				# ================== API to get user by id ==================
				desc 'API to find user by id'
				params do
					requires :user_id, type: Integer, desc: "User's ID"
				end
				get 'find_user' do
					user_id = params[:user_id]
					user = User.find_by_id(user_id)
					if user
						data = API::V1::Entities::Users::User.represent(user)
						code = '200'
						status = 'ok'
					else
						code = '404'
						status = 'Not found'
						data = "Couldn't find user with id: #{params[:user_id]}"
					end

      		return {
            code: code, status: status , data: {user: data}
          }
				end

				# ================== API to update user ==================
				desc 'Update user'
				params do
					requires :user_id, type: Integer, desc: "User to be updated"
					requires :user, type: Hash do
						optional :first_name, type: String, desc: "First name"
						optional :last_name, type: String, desc: "Last name"
						optional :email, type: String, desc: "User email"
						optional :profile_url, type: String, desc: "FB profile url"
						optional :longitude, type: String, desc: "Current location's longitude"
						optional :latitude, type: String, desc: "Current location's latitude"
						optional :message, type: String, desc: "Message for pakistan"
						optional :password, type: String, desc: "FB access token"
					end
				end

				put 'update_user' do
					user = User.find_by_id(params[:user_id])
					if user.update_attributes declared(params).user
						response_data = API::V1::Entities::Users::User.represent(user)
					else
						response_data = user.errors
					end
          return {
            data: response_data
          }
				end

				# ================== API to create user ==================
				desc 'Create user'
				params do
					requires :user, type: Hash do
						optional :first_name, type: String, desc: "First name"
						optional :last_name, type: String, desc: "Last name"
						requires :email, type: String, desc: "User email"
						requires :fb_id, type: Integer, desc: "User's FB uid'"
						optional :profile_url, type: String, desc: "FB profile url"
						optional :longitude, type: Float, desc: "Current location's longitude"
						optional :latitude, type: Float, desc: "Current location's latitude"
						optional :message, type: String, desc: "Message for pakistan"
						optional :password, type: String, desc: "FB access token"
					end
				end

				post 'create_user' do
					user = User.new(declared(params).user)
					if user.save
						code = '200'
						status = 'Created'
						response_data = API::V1::Entities::Users::User.represent(user)
					else
						code = '422'
						status = 'Unprocessable entity'
						response_data = user.errors
					end
					return {
							code: code, status: status , data: response_data
					}
				end

			end
		end # ================== END OF CLASS ==================
	end
end
