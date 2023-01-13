# frozen_string_literal: true

require 'rails_helper'


describe '投稿のテスト' do
  let!(:board) { create(:board,title:'hoge',body:'body') }
  describe 'トップ画面(root_path)のテスト' do
    before do 
      visit root_path
    end
  end
end
	  