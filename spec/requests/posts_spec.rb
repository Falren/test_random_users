require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  describe 'GET /api/v1/posts' do
    let!(:posts) { create_list(:post, 3) }

    before { get '/api/v1/posts' }

    it 'returns a list of posts' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(posts.as_json)
    end
  end

  describe 'GET /api/v1/posts/:id' do
    let!(:post) { create(:post) }
    before { get "/api/v1/posts/#{post.id}" }

    it 'returns a post' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(post.as_json)
    end
  end

  describe 'POST /api/v1/posts' do
    context 'with valid parameters' do
      it 'creates a post' do
        post_params = attributes_for(:post)
        expect { post '/api/v1/posts', params: { post: post_params } }.to change { Post.count }.by(1)

        expect(JSON.parse(response.body)).to eq(Post.last.as_json)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns errors' do
        post_params = { title: nil, body: nil }

        post '/api/v1/posts', params: { post: post_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq(
          "body" => ["can't be blank"],
          "title" => ["can't be blank"]
        )
      end
    end
  end

  describe 'PATCH /api/v1/posts/:id' do
    context 'with valid parameters' do
      it 'updates a post' do
        post = create(:post)

        patch "/api/v1/posts/#{post.id}", params: { post: { title: 'NewTitle' } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(Post.find_by(id: post.id).as_json)
      end
    end

    context 'with invalid parameters' do
      it 'returns errors' do
        post = create(:post)

        patch "/api/v1/posts/#{post.id}", params: { post: { title: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq(
          "title" => ["can't be blank"]
        )
      end
    end
  end

  describe 'DELETE /api/v1/posts/:id' do
    it 'deletes a post' do
      post = create(:post)

      delete "/api/v1/posts/#{post.id}"

      expect(response).to have_http_status(:no_content)
    end
  end
end
