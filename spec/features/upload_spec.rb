require 'spec_helper'

feature 'AJAX file uploading', js: true do
  scenario 'uploads the file correctly' do
    visit root_path
    attach_file 'upload', Rails.root.join(*%w(public ralph.png)).to_s

    expect(page).to have_css('.attachments img')
    expect(Asset.last.file_file_name).to eq 'ralph.png'
  end
end
