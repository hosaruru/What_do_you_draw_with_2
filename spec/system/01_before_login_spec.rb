# require 'rails_helper'

# describe '[STEP1] ユーザログイン前のテスト' do
#   describe 'トップ画面のテスト' do
#     before do
#       visit root_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users/sign_in'
#       end
#       it 'Twitterログインリンクが表示される: ボタンの表示が「Twitterアカウントで新規登録・ログイン」である' do
#         log_in_link = find_all('a')[5].native.inner_text
#         expect(log_in_link).to match(/Twitterアカウントで新規登録・ログイン/)
#       end
#       it 'Twitterログインリンクの内容が正しい' do
#         log_in_link = find_all('a')[5].native.inner_text
#         expect(page).to have_link log_in_link, href: new_user_session_path
#       end
#       it 'ゲストログインリンクが表示される: ボタンの表示が「ゲストログイン（閲覧用）」である' do
#         sign_up_link = find_all('a')[6].native.inner_text
#         expect(sign_up_link).to match(/ゲストログイン（閲覧用）/)
#       end
#       it 'ゲストログインリンクの内容が正しい' do
#         sign_up_link = find_all('a')[6].native.inner_text
#         expect(page).to have_link sign_up_link, href: guest_sign_in_path
#       end
#     end
#   end

#   describe 'ヘッダーのテスト: ログインしていない場合' do
#     before do
#       visit root_path
#     end

#     context '表示内容の確認' do
#       it 'Sign inリンクが表示される: リンク名が「新規登録・ログイン」である' do
#         expect(signin_link).to match(/新規登録・ログイン/)
#       end
#     end

#     context 'リンクの内容を確認' do
#       subject { current_path }
#       it 'Sign upを押すと、新規登録画面に遷移する' do
#         click_link signin_link, match: :first
#         is_expected.to eq '/users/sign_in'
#       end
#     end
#   end

#   describe 'ユーザ新規登録のテスト' do
#     before do
#       visit new_user_registration_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users/sign_in'
#       end
#       it '「Sign up」と表示される' do
#         expect(page).to have_content 'Sign up'
#       end
#       it 'nameフォームが表示される' do
#         expect(page).to have_field 'user[name]'
#       end
#       it 'emailフォームが表示される' do
#         expect(page).to have_field 'user[email]'
#       end
#       it 'passwordフォームが表示される' do
#         expect(page).to have_field 'user[password]'
#       end
#       it 'password_confirmationフォームが表示される' do
#         expect(page).to have_field 'user[password_confirmation]'
#       end
#       it 'Sign upボタンが表示される' do
#         expect(page).to have_button 'Sign up'
#       end
#     end

#     context '新規登録成功のテスト' do
#       before do
#         fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
#         fill_in 'user[email]', with: Faker::Internet.email
#         fill_in 'user[password]', with: 'password'
#         fill_in 'user[password_confirmation]', with: 'password'
#       end

#       it '正しく新規登録される' do
#         expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
#       end
#       it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
#         click_button 'Sign up'
#         expect(current_path).to eq '/users/' + User.last.id.to_s
#       end
#     end
#   end

#   describe '要確認ヘッダーのテスト: ログインしている場合' do
#     let(:user) { create(:user) }

#     before do
#       visit new_user_session_path
#       fill_in 'user[name]', with: user.name
#       fill_in 'user[password]', with: user.password
#       click_button 'Log in'
#     end

#     context 'ヘッダーの表示を確認' do
#       it 'TOPリンクが表示される: 左上から1番目のリンクが「TOP」である' do
#         post_link = find_all('a')[0].native.inner_text
#         expect(post_link).to match(/TOP/)
#       end
#       it 'マイページリンクが表示される: 左上から2番目のリンクが「マイページ」である' do
#         users_link = find_all('a')[1].native.inner_text
#         expect(users_link).to match(/マイページ/)
#       end
#       it '投稿リンクが表示される: 左上から3番目のリンクが「投稿」である' do
#         users_link = find_all('a')[2].native.inner_text
#         expect(posts_link).to match(/投稿/)
#       end
#       it 'ブックマークリンクが表示される: 左上から4番目のリンクが「ブックマーク」である' do
#         users_link = find_all('a')[3].native.inner_text
#         expect(users_link).to match(/ブックマーク/)
#       end
#       it '掲示板リンクが表示される: 左上から5番目のリンクが「掲示板」である' do
#         boards_link = find_all('a')[4].native.inner_text
#         expect(boards_link).to match(/掲示板/)
#       end
#       it 'ログアウトリンクが表示される: 左上から6番目のリンクが「ログアウト」である' do
#         logout_link = find_all('a')[5].native.inner_text
#         expect(logout_link).to match(/ログアウト/)
#       en
#     end
#   end

#   describe '要確認ユーザログアウトのテスト' do
#     let(:user) { create(:user) }

#     before do
#       visit new_user_session_path
#       fill_in 'user[name]', with: user.name
#       fill_in 'user[password]', with: user.password
#       click_button 'Log in'
#       logout_link = find_all('a')[4].native.inner_text
#       logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
#       click_link logout_link
#     end

#     context 'ログアウト機能のテスト' do
#       it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
#         expect(page).to have_link '', href: '/home/about'
#       end
#       it 'ログアウト後のリダイレクト先が、トップになっている' do
#         expect(current_path).to eq '/'
#       end
#     end
#   end
# end　