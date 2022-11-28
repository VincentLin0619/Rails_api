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
      article = create(:article)
      get "/articles"
      expect(json_data).to eq(
        [
          {
            id: article.id.to_s,
            type: "articles",
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
