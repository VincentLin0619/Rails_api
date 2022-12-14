require "rails_helper"

# RSpec.describe "/articles routes" do
#   it "checkout routes to article" do
#     aggregate_failures do
#       expect(get "/articles").to route_to("article#index")
#       expect(get "/article/1").to route_to("article#show", id: "1")
#     end
#   end
# end
RSpec.describe ArticleController, type: :request do
  describe "#index" do
    it "check res" do
      get "/articles"
      expect(response).to have_http_status(:ok)
    end
    it "returns a proper JSON" do
      article = create(:article)
      get "/articles"
      expect(json_data.length).to eq(1)
      expected = json_data.first
      expect(expected[:id]).to eq(article.id.to_s)
      expect(expected[:type]).to eq("articles")
      expect(expected[:attributes]).to eq(
        title: article.title,
        content: article.content,
        slug: article.slug,
      )
    end

    it "returns article in the proper order " do
      get "/articles"
      ids = json_data.map { |item| item[:id].to_i }
      expect(ids).to eq([recent_article.id, older_article.id])
      pp ids
    end
  end
end
