require 'rails_helper'

describe 'boardのテスト' do
  let!(:board) {create(:board,headline:'test',text:'test') }
  let!(:user) {create(:user)}
  describe '掲示板画面(boards_path)のテスト' do
    before do 
      login_as(user)
      visit boards_path
    end
  end
  
  describe "掲示画面のテスト" do
    before do
      login_as(user)
      visit boards_path
    end
    context '一覧の表示とリンクの確認' do
      it "投稿のリンクが表示されているか" do
        visit boards_path
        new_link = page.all('a', :text => /投稿する/)
      end
    end
  end
  
  describe "投稿処理に関するテスト" do
    before do
    login_as(user)
    visit new_board_path
  end
    context '表示の確認' do
      it "タイトル、本文の入力ボックスが表示されているか" do
        visit new_board_path
        expect(page).to have_field 'board[headline]'
        expect(page).to have_field 'board[question]'
      end
      it "投稿のリンクが表示されているか" do
        new_link = page.all('a', :text => /投稿！/)
      end
    end
    context '挙動の確認' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        visit new_board_path
        fill_in 'board[headline]', with: Faker::Lorem.characters(number:20)
        fill_in 'board[question]', with: Faker::Lorem.characters(number:5)
        click_button '投稿！'
      end
      it '投稿に失敗する' do
        visit new_board_path
        click_button '投稿！'
        expect(page).to have_content '必須です'
        expect(current_path).to eq boards_path
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'board[headline]', with: Faker::Lorem.characters(number:5)
        fill_in 'board[question]', with: Faker::Lorem.characters(number:20)
        click_button '投稿！'
        expect(page).to have_current_path board_path(Board.last)
      end
    end
  end
    
    



  describe '詳細画面のテスト' do
    before do
      login_as(user)
      visit board_path(board)
    end
    context '表示の確認' do
      it '編集リンクが表示される' do
        edit_link = find_all('a')[0]
        expect(edit_link.native.inner_text).to match(/edit/i)
			end
    end
    context '編集ボタンの遷移先の確認' do
      it '編集ボタンの遷移先は編集画面か' do
        edit_link = find_all('a')[0]
        edit_link.click
        expect(current_path).to eq('/boards/' + board.id.to_s + '/edit')
      end
    end
    context 'board削除のテスト' do
      it 'boardの削除' do
        before_delete_board = Board.count
        click_link '削除'
        after_delete_board = Board.count
        expect(before_delete_board - after_delete_board).to eq(1)
        expect(current_path).to eq('/boards')
      end
    end
  end
  
  
  
  describe '編集画面のテスト' do
    before do
      login_as(user)
      visit edit_board_path(board)
    end
    context '表示の確認' do
      it '要確認編集前のタイトルと感想がフォームに表示(セット)されている' do
        expect(page).to have_field 'board[twitter]', with: board.twitter
        expect(page).to have_field 'board[brush]', with: board.brush
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end 
    end
    context '更新処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'board[twitter]', with: ""
        fill_in 'board[brush]', with: ""
        click_button '保存'
        expect(page).to have_content '必須です'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'board[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'board[brush]', with: Faker::Lorem.characters(number:5)
        click_button '保存'
        expect(page).to have_current_path board_path(board)
      end
    end
  end
end