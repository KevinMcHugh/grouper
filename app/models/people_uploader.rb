# Upload many people!
class PeopleUploader
  def upload yaml
    people = YAML.load(yaml)["people"]
    people.map { |person| Person.new person}
  end
end
