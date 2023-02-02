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
      it '投稿に成功しサクセスメッセージが表示されるか' do
        visit new_post_path
        fill_in 'post[twitter]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[brush]', with: Faker::Lorem.characters(number:5)
        fill_in 'post.software[name]', with: Faker::Lorem.characters(number:2)
        click_button '投稿！'
        expect(page).to have_content '投稿できました。Twitterで共有してみましょう！'
      end
      it '投稿に失敗する' do
        visit new_post_path
        click_button '投稿！'
        expect(page).to have_content '必須です'
        expect(current_path).to eq posts_path
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button '投稿！'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end