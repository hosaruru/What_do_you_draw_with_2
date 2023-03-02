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
        new_link = page.all('a', :text => /投稿！/)
      end
    end
    context '挙動の確認' do
      let!(:software) {create(:software)}

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

  describe '詳細画面のテスト' do
    before do
    login_as(user)
    end
    context '表示の確認' do
      it '編集リンクが表示される' do
        visit root_path
        click_button '詳細'
        edit_link = page.all('a', :text => /編集/)
			end
    end
    context '編集ボタンの遷移先の確認' do
      it '編集ボタンの遷移先は編集画面か' do
        visit root_path
        click_button '詳細'
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
  end
  
  
  
  describe '編集画面のテスト' do
    before do
      login_as(user)
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it '要確認編集前の内容がフォームに表示(セット)されている' do
        visit edit_post_path(post)
        expect(page).to have_field 'post[twitter]', with: post.twitter
        expect(page).to have_field 'post[brush]', with: post.brush
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end 
    end
    context '更新処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'post[twitter]', with: ""
        fill_in 'post[brush]', with: ""
        click_button '保存'
        expect(page).to have_content '必須です'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        click_button '保存'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end