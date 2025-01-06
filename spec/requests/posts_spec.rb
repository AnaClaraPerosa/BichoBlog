require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'returns a successful response' do
      get posts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /posts' do
    it 'creates a new post' do
      user = User.create!(email: 'user@example.com', password: 'password')
      sign_in user

      post posts_path, params: { post: { title: 'Novo Post', content: 'Conteúdo' } }
      expect(response).to redirect_to(post_path(Post.last))
    end
  end
end
