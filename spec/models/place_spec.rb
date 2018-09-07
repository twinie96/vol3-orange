require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) { build(:place) }

  it 'checks for presence of name' do
    place.name = nil
    expect(place).not_to be_valid
    expect(place.errors[:name][0]).
      to include("can't be blank")
  end

  it 'checks for start date after end date' do
    place.end_date = place.start_date - 1
    expect(place).not_to be_valid
    expect(place.errors[:end_date][0]).
      to include("must be after or equal to")
  end

  it 'checks for place start date after trips' do
    place.trip.start_date = Time.now
    place.start_date = Time.zone.yesterday
    expect(place).not_to be_valid
    expect(place.errors[:start_date][0]).
      to include("can't be earlier than")
    place.start_date = Time.zone.tomorrow
    expect(place).to be_valid
  end

  it 'checks for place end date before than trips' do
    place.trip.end_date = Time.zone.tomorrow
    place.end_date = Time.zone.tomorrow + 1
    expect(place).not_to be_valid
    expect(place.errors[:end_date][0]).
      to include("can't be later than")
    place.end_date = Time.now
    expect(place).to be_valid
  end
end
