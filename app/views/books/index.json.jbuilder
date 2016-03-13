json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :start, :end, :rating
  json.url book_url(book, format: :json)
end
