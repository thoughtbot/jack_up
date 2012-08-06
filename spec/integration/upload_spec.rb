require 'spec_helper'

feature 'AJAX file uploading', js: true do
  scenario 'uploads the file correctly' do
    visit root_path
    attach_file 'upload', Rails.root.join(*%w(public ralph.png)).to_s

    find('.attachments img').should be_present
    Asset.last.file_file_name.should eq 'ralph.png'
  end
end
