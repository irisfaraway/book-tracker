require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end


describe Book do

  let(:book_params) { {
    title: 'My Brilliant Friend',
    author: 'Elena Ferrante',
    start: '2015-01-01',
    end: '2016-01-01',
    rating: '5'
  } }
  let(:book) { Book.new book_params }

  it 'is valid when created with valid parameters' do
    book.must_be :valid?
  end

  it 'is invalid without a title' do
    book_params.delete :title
    book.wont_be :valid?
    book.errors[:title].must_be :present?
  end

  it 'is invalid without an author' do
    book_params.delete :author
    book.wont_be :valid?
    book.errors[:author].must_be :present?
  end

  it 'is invalid without a start date' do
    book_params.delete :start
    book.wont_be :valid?
    book.errors[:start].must_be :present?
  end

end
