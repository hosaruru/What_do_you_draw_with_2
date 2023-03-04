require 'rails_helper'

describe 'postのテスト' do
  let!(:post) {create(:post) }
  let!(:user) {create(:user)}
  describe 'トップ画面(root_path)のテスト' do
    before do 
      login_as(user)
      visit root_path
    end
    context '表示の確認' do
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  describe "一覧画面のテスト" do
    before do
      login_as(user)
      visit root_path
    end
    context '一覧の表示とリンクの確認' do
      it "ペンの検索ボックスが表示されているか" do
        expect(page).to have_selector 'form'
        expect(page).to have_field 'q[brush_cont]'
        expect(page).to have_field 'q[pens_use_pen_cont]'
      end
      it "ツイッター、ユーザー名、使用ソフト、ペン、タグ、詳細のリンクが表示されているか" do
        visit posts_path
        expect(page).to have_content post.twitter
        expect(page).to have_content user.user_name
        expect(page).to have_content post.software.name
      end
      it "詳細のリンクが表示されているか" do
        show_link = page.all('a', :text => /詳細/)
      end
    end
  end
  
  describe "投稿処理に関するテスト" do
    before do
    login_as(user)
  end
    context '表示の確認' do
      it "ツイッター、使用ソフト、ペンの入力ボックスが表示されているか" do
        visit new_post_path
        expect(page).to have_field 'post[twitter]'
        expect(page).to have_field 'post[software_id]'
        expect(page).to have_field 'post[brush]'
      end
      it "投稿のリンクが表示されているか" do
        visit new_post_path
        expect(page).to have_button 'OK！'
      end
    end
    context '挙動の確認' do
      let!(:software) {create(:software)}
      it '更新に失敗しエラーメッセージが表示されるか' do
        visit new_post_path
        click_button 'OK！'
        expect(page).to have_content '*は必須です。'
end
      it '投稿に成功しサクセスメッセージが表示されるか' do
        visit new_post_path
        expect(page).to have_field 'post[twitter]'
        expect(page).to have_field 'post[software_id]'
        expect(page).to have_field 'post[brush]'
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        select software.name,from: 'post[software_id]'
        click_button 'OK！'
        expect(page).to have_content '投稿できました。Twitterで共有してみましょう！'
      end
      it '投稿後のリダイレクト先は正しいか' do
        visit new_post_path
        expect(page).to have_field 'post[twitter]'
        expect(page).to have_field 'post[software_id]'
        expect(page).to have_field 'post[brush]'
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        select software.name,from: 'post[software_id]'
        click_button 'OK！'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
      it '投稿に失敗する' do
        visit new_post_path
        click_button 'OK！'
        expect(page).to have_content '必須です'
      end
  end

  describe '編集画面のテスト' do
    before do
    login_as(user)
    end
    context '表示の確認' do
      let!(:software) {create(:software)}
      it '編集リンクが表示され、遷移先は編集画面か' do
        visit new_post_path
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        select software.name,from: 'post[software_id]'
        click_button 'OK！'
        click_link '編集'
        expect(current_path).to eq('/posts/2/edit')
			end
    end
    
    context '表示の確認' do
      let!(:software) {create(:software)}
      it 'OK！ボタンが表示される' do
        visit new_post_path
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        select software.name,from: 'post[software_id]'
        click_button 'OK！'
        click_link '編集'
        click_button 'OK！'
      end 
    end
    context '更新処理に関するテスト' do
      let!(:software) {create(:software)}
      it '更新に失敗しエラーメッセージが表示されるか' do
        visit new_post_path
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        select software.name,from: 'post[software_id]'
        click_button 'OK！'
        click_link '編集'
        fill_in 'post[twitter]', with: ""
        fill_in 'post[brush]', with: ""
        click_button 'OK！'
        expect(page).to have_content '必須です'
      end
      let!(:software) {create(:software)}
      it '更新後のリダイレクト先は正しいか' do 
        visit new_post_path
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        select software.name,from: 'post[software_id]'
        click_button 'OK！'
        click_link '編集'
        fill_in 'post[twitter]', with: ""
        fill_in 'post[brush]', with: ""
        click_button 'OK！'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end
end