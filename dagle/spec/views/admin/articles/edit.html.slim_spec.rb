require 'rails_helper'

RSpec.describe "admin/articles/edit", type: :view do
  before(:each) do
    @article = assign(:article, Article.create!(id: 1, ))
  end
  it "renders the edit admin_article form" do
    render
    assert_select "form[action=?][method=?]", admin_article_path(@article), "post" do
    end
  end
end
