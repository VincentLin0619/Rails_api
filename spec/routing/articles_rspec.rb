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
    it "return a proper JSON" do
      article = FactoryBot.create(:article)
      get "/articles"
      body = JSON.parse(response.body)
      expect(body).to eq(
        data: [
          {
            id: article.id,
            type: "article",
            attributes: {
              title: article.title,
              content: article.content,
              slug: article.slug,
            },
          },
        ],
      )
    end
  end
end
