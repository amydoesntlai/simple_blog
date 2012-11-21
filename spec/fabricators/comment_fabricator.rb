Fabricator(:comment) do
  article
  body { sequence { |i| "#{Faker::Lorem.sentence} (#{i})"} }
end