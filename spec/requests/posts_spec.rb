require 'rails_helper'

RSpec.describe 'Posts  ', type: :request do
  context 'testing GET /index' do
    it 'should return http success' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:success)
    end
    it 'should return response body that includes correct placeholder text' do
      get '/users/:user_id/posts'
      expect(response.body).to include 'Here is a list of posts for a given user'
    end
    it 'should render users index page' do
      get '/users/:user_id/posts'
      expect(response).to render_template('index')
    end
  end

  context 'Testing GET /show' do
    it 'should return http success' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(:success)
    end
    it 'should return response body that includes correct placeholder text' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to include 'Here is the individual post'
    end
    it 'should render users show page' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template('show')
    end
  end
end
