json.array!(@pages) do |page|
  json.extract! page, :id, :title, :slug, :body, :published
  json.url page_url(page, format: :json)
end
