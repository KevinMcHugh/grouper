require 'spec_helper'

describe EventsUploadersController do
  describe '#create' do
    let(:file) {fixture_file_upload('files/event_upload.yaml', 'text/yaml')}
    # let(:events_uploader) { double(EventsUploader).as_null_object }
    let(:event) {build :event}
    it 'saves an event' do
      expect_any_instance_of(Event).to receive(:save)
      expect_any_instance_of(EventsUploader).to receive(:upload).and_return(event)
      post :create, "events_uploader" => {"file" => file}
    end
  end
end