require 'rails_helper'

RSpec.describe 'Boardモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { board.valid? }

    let(:user) { create(:user) }
    let!(:board) { build(:board, user_id: user.id) }
    
    context 'headline' do
      it '空欄でないこと' do
        board.headline = ''
        is_expected.to eq false
      end
    end

    context 'question' do
      it '空欄でないこと' do
        board.question = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Board.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
