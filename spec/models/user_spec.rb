# require 'rails_helper'

# RSpec.describe User, type: :model do
#   describe "associations" do
#     it { should have_many(:blog_posts).dependent(:destroy) }
#     it { should have_one_attached(:cv) }
#   end

#   describe "validations" do
#     it { should validate_presence_of(:email) }
#     it { should validate_uniqueness_of(:email) }
#   end

#   describe "cv_format_and_size" do
#     let(:user) { User.new(email: "test@example.com", password: "password") }
#     let(:pdf_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.pdf'), 'application/pdf') }
#     let(:txt_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.txt'), 'text/plain') }
#     let(:large_file) { double('large_file', byte_size: 6.megabytes, content_type: 'application/pdf') }
#     let(:invalid_type) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpeg') }

#     context "with a valid PDF file" do
#       it "does not add errors" do
#         user.cv.attach(pdf_file)
#         user.valid?
#         expect(user.errors[:cv]).to be_empty
#       end
#     end

#     # Add more test cases as needed
#   end
# end
