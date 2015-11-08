json.array!(@letters) do |letter|
  json.extract! letter, :id, :subject, :body, :done
  json.url letter_url(letter, format: :json)
end
