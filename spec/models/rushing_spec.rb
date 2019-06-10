require 'rails_helper'

RSpec.describe Rushing, type: :model do
  before do 
    @file = ActionDispatch::Http::UploadedFile.new({
      filename: 'rushing.json',
      type: "application/json",
      tempfile: file_fixture("rushing.json").open
      })
  end
  it 'assign file ' do
    rushing = Rushing.new file: @file
    expect(rushing.file).to eq(@file)
  end

  it 'raise error for invalid format' do
    rushing = Rushing.new file: ActionDispatch::Http::UploadedFile.new({
      filename: 'other_format.kml',
      type: "application/kml",
      tempfile: file_fixture("other_format.kml").open
      })
    expect(rushing.valid?).to eq(false)
    expect(rushing.errors[:base]).to eq(["file must be in json format."])
  end

  it 'is invalid when no file is present' do
    rushing = Rushing.new 
    expect(rushing.valid?).to eq(false)
  end

  it 'raise error when file is empty' do
    rushing = Rushing.new file: ActionDispatch::Http::UploadedFile.new({
      filename: 'blank.json',
      type: "application/json",
      tempfile: file_fixture("blank.json").open
      })
    expect(rushing.valid?).to eq(false)
    expect(rushing.errors[:base]).to eq(["file is empty"])
  end

  it 'assign items' do
    rushing = Rushing.new file: @file
    rushing.valid?
    expect(rushing.items).to contain_exactly({"Player"=>"Joe Banyard", "Team"=>"JAX", "Pos"=>"RB", "Att"=>2, "Att/G"=>2, "Yds"=>7, "Avg"=>3.5, "Yds/G"=>7, "TD"=>0, "Lng"=>"7", "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0})
  end

  it 'assign keys' do
    rushing = Rushing.new file: @file
    rushing.valid?
    expect(rushing.keys).to eq(["Player", "Team", "Pos", "Att", "Att/G", "Yds", "Avg", "Yds/G", "TD", "Lng", "1st", "1st%", "20+", "40+", "FUM"])
  end
end