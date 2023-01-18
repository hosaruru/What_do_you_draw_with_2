require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    
    context 'twitterカラム' do
      it '空欄でないこと' do
        post.twitter = ''
        is_expected.to eq false
      end
    end

    context 'brushカラム' do
      it '空欄でないこと' do
        post.brush = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Softwareモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:software).macro).to eq :belongs_to
      end
    end
  end
end
