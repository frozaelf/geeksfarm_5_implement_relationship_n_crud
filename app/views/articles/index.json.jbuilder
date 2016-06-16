json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :image, :published
  json.url article_url(article, format: :json)
end
