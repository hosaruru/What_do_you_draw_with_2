RSpec.describe User, type: :model do
  it "姓、名を登録すると、姓名が取得できること"
     describe 'validation' do
      example 'user_nameは必須' do
        user = FactoryBot.build(:user, user_name: nil)
        expect(user).to be_invalid
      end
    end
end
