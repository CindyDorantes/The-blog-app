require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'testing GET /users' do
    it 'should return http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
    it 'should return response body that includes correct placeholder text' do
      get '/users'
      expect(response.body).to include 'Here is a list of users'
    end
    it 'should render users index page' do
      get '/'
      expect(response).to render_template('index')
    end
  end

  context 'Testing GET /show' do
    it 'should return http success' do
      get '/users/:id'
      expect(response).to have_http_status(:success)
    end
    it 'should return response body that includes correct placeholder text' do
      get '/users/:id'
      expect(response.body).to include 'Here is the information for a given user'
    end
    it 'should render users show page' do
      get '/users/:id'
      expect(response).to render_template('show')
    end
  end
end
