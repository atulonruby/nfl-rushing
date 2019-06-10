class Rushing

  include ActiveModel::Model

  attr_accessor :file, :items, :keys
  validates :file, presence: true
  validate :file_format
  validate :check_and_extract_content 
  
  def initialize(attr = {})
    @file = attr[:file] if attr[:file].present?
  end

  def fetch_items
    @items ||= JSON.parse(file.read)
  end

  def fetch_keys
    @keys = fetch_items.first.keys
  end

  private

  def file_format
    unless file.try(:content_type) == "application/json"
      errors[:base] << "file must be in json format." 
      throw(:abort)
    end
  end

  def check_and_extract_content
    fetch_items 
    errors[:base] << "file is empty" unless @items.length > 0
    fetch_keys if items.present?
  end  
end
