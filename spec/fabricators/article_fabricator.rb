Fabricator(:article) do
  title { sequence(:title_counter) { |i| "#{Faker::Lorem.sentence} (#{i})"} }
  body  { Faker::Lorem.paragraphs(3).join('\n') }
end

Fabricator(:article_with_comments, :from => :article) do
  comments(:count => 3) { |article, index| Fabricate(:comment) }
end