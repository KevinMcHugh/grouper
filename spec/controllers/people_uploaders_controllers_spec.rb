require 'spec_helper'

describe PeopleUploadersController do
  describe '#create' do
    let(:file) {fixture_file_upload('files/people_upload.yaml', 'text/yaml')}
    let(:alice) {build :person}
    let(:bob) {build :bob}
    it 'saves people' do
      # expect_any_instance_of(Person).to receive(:save).twice
      # There's no way to specify that 2 instances should each receive it once
      expect_any_instance_of(PeopleUploader).to receive(:upload).and_return([alice,bob])
      post :create, "people_uploader" => {"file" => file}
    end
  end
end