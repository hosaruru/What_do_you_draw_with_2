require 'rails_helper'

describe '投稿のテスト' do
  let!(:post) { create(:post,twitter:'test',software_id:'1',brush:'test') }
  describe 'トップ画面(root_path)のテスト' do
    before do 
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
      visit root_path
    end
    context '一覧の表示とリンクの確認' do
      it "ペンの検索ボックスが表示されているか" do
        expect(page).to have_selector 'form'
        expect(page).to have_field 'q[brush_cont]'
        expect(page).to have_field 'q[pens_use_pen_cont]'
      end
      it "postのツイッター、ユーザー名、使用ソフト、ペン、タグ、詳細のリンクが表示されているか" do
          visit posts_path
            expect(page).to have_content post.twitter
            expect(page).to have_content user.name
            expect(page).to have_content software.name
            expect(page).to have_content post.twitter
            # Showリンク
            show_link = find_all('a')[j]
            expect(show_link.native.inner_text).to match(/show/i)
            expect(show_link[:href]).to eq post_path(post)
      end
      it 'Create Postボタンが表示される' do
        expect(page).to have_button 'Create Post'
      end
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Create Post'
        expect(page).to have_content 'successfully'
      end
      it '投稿に失敗する' do
        click_button 'Create Post'
        expect(page).to have_content 'error'
        expect(current_path).to eq('/posts')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Create Post'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
    context 'post削除のテスト' do
      it 'application.html.erbにjavascript_pack_tagを含んでいるか' do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.gsub(" ", "")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      it 'postの削除' do
        before_delete_post = Post.count
        click_link 'Destroy'
        after_delete_post = Post.count
        expect(before_delete_post - after_delete_post).to eq(1)
        expect(current_path).to eq('/posts')
      end
    end
  end
  describe '詳細画面のテスト' do
    before do
      visit post_path(post)
    end
    context '表示の確認' do
      it '本のタイトルと感想が画面に表示されていること' do
        expect(page).to have_content post.title
        expect(page).to have_content post.body
      end
      it 'Editリンクが表示される' do
        edit_link = find_all('a')[0]
        expect(edit_link.native.inner_text).to match(/edit/i)
			end
      it 'Backリンクが表示される' do
        back_link = find_all('a')[1]
        expect(back_link.native.inner_text).to match(/back/i)
			end  
    end
    context 'リンクの遷移先の確認' do
      it 'Editの遷移先は編集画面か' do
        edit_link = find_all('a')[0]
        edit_link.click
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
      it 'Backの遷移先は一覧画面か' do
        back_link = find_all('a')[1]
        back_link.click
        expect(page).to have_current_path posts_path
      end
    end
  end
  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it '編集前のタイトルと感想がフォームに表示(セット)されている' do
        expect(page).to have_field 'post[title]', with: post.title
        expect(page).to have_field 'post[body]', with: post.body
      end
      it 'Update Postボタンが表示される' do
        expect(page).to have_button 'Update Post'
      end
      it 'Showリンクが表示される' do
        show_link = find_all('a')[0]
        expect(show_link.native.inner_text).to match(/show/i)
			end  
      it 'Backリンクが表示される' do
        back_link = find_all('a')[1]
        expect(back_link.native.inner_text).to match(/back/i)
			end  
    end
    context 'リンクの遷移先の確認' do
      it 'Showの遷移先は詳細画面か' do
        show_link = find_all('a')[0]
        show_link.click
        expect(current_path).to eq('/posts/' + post.id.to_s)
      end
      it 'Backの遷移先は一覧画面か' do
        back_link = find_all('a')[1]
        back_link.click
        expect(page).to have_current_path posts_path
      end
    end
    context '更新処理に関するテスト' do
      it '更新に成功しサクセスメッセージが表示されるか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Update Post'
        expect(page).to have_content 'successfully'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'post[title]', with: ""
        fill_in 'post[body]', with: ""
        click_button 'Update Post'
        expect(page).to have_content 'error'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Update Post'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end