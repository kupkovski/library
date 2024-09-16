require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      create(:book,
        title: "Title",
        author_name: "Author Name",
        genre: "Genre",
        isbn: "Isbn",
        total_copies: 2
      ),
      create(:book,
        title: "Title",
        author_name: "Author Name",
        genre: "Genre",
        isbn: "Isbn",
        total_copies: 2
      )
    ])
  end

  it "renders a list of books" do
    render
    cell_selector = 'table>tbody>tr'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Author Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Genre".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Isbn".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
