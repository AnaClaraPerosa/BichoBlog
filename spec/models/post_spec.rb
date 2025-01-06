require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it 'is valid with a title and content' do
      post = Post.new(title: 'Meu Post', content: 'Conteúdo do post')
      expect(post).to be_valid
    end

    it 'is invalid without a title' do
      post = Post.new(content: 'Conteúdo do post')
      expect(post).not_to be_valid
    end
  end
end
