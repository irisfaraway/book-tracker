json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :start_date, :end_date, :rating
  json.url book_url(book, format: :json)
end
