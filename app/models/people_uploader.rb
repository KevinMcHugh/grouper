class PeopleUploader

  def upload yaml
    create_people parse(yaml)
  end

  def parse yaml
    people = YAML.load(yaml)["people"]
    people.map { |person| Person.new person}
  end

  def create_people people
    people.each do |person|
      person.save
    end
  end
end
