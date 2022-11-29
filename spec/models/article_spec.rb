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

  # 前面加上. 為一個類別方法而不是實體方法
  describe ".recent" do
    # 測試在 Article Model 裡新增的 recent 方法是否回傳正常的排序，最新的文章排在前面
    it "returns article in the proper order " do
      older_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      expect(described_class.recent).to eq([recent_article, older_article])

      #上面的測試成功後，把recent_article的創建時間更新為兩個小時之後，在expect是否為預期的順序
      recent_article.update_column(:created_at, 2.hours.ago)
      expect(described_class.recent).to eq([older_article, recent_article])

      p described_class.recent
    end
  end
end
