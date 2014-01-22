class PersonUploader

  def create_people people
    people.each do |person|
      person.save
    end
  end
end