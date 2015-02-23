require 'rails_helper'

RSpec.describe Page, type: :model do
  it "has a valid factory" do
    page = FactoryGirl.build :page
    expect(page).to be_valid
  end

  it "is invalid without a title" do
    page = FactoryGirl.build :page, title: nil
    expect(page).to be_invalid
  end

  it "is invalid with an empty title" do
    page = FactoryGirl.build :page, title: ''
    expect(page).to be_invalid
  end

  it "is invalid without a slug" do
    page = FactoryGirl.build :page, slug: nil
    expect(page).to be_invalid
  end

  it "is invalid with an empty slug" do
    page = FactoryGirl.build :page, slug: ''
    expect(page).to be_invalid
  end
end