require 'rails_helper'

RSpec.describe "books/show", type: :view do
  let(:user) { create(:user) }

  before(:each) do
    allow(view).to receive(:current_user).and_return(user)

    assign(:book, create(:book,
      title: "Title",
      author_name: "Author Name",
      genre: "Genre",
      isbn: "Isbn",
      total_copies: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Author Name/)
    expect(rendered).to match(/Genre/)
    expect(rendered).to match(/Isbn/)
    expect(rendered).to match(/2/)
  end
end
