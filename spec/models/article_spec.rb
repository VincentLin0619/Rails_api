require "rails_helper"

RSpec.describe Article, type: :model do
  describe "#validations" do
    let(:article) { FactoryBot.create(:article) }
    it "test Article is valid?" do
      expect(article).to be_valid
    end

    it "測試title是否驗證不能為空" do
      article.title = ""
      expect(article).not_to be_valid
      # 期望錯誤訊息是 can't be blank
      expect(article.errors[:title]).to include("can't be blank")
    end
    it "測試content是否驗證不能為空" do
      article.content = ""
      expect(article).not_to be_valid
      # 期望錯誤訊息是 can't be blank
      expect(article.errors[:content]).to include("can't be blank")
    end
    it "測試slug是否驗證為唯一值" do
      article_1 = FactoryBot.create(:article)
      expect(article_1).to be_valid
      article_2 = FactoryBot.build(:article, slug: article_1.slug)
      expect(article_2).not_to be_valid

      # 期望錯誤訊息是 Slug has already been taken
      expect(article_2.errors[:slug]).to include("has already been taken")
    end
  end
end
