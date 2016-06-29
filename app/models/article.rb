require 'roo'
class Article < ActiveRecord::Base
  has_attached_file :image, styles: { large: "600x300>", medium: "400x200>", thumb: "100x200>"}
  #name relation must plural
  has_many :comments, dependent: :destroy
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_attachment :image, presence: true,content_type: { content_type: "image/jpeg" } 
  def self.to_csv()
    headers = ['Title', 'Content']
    CSV.generate_line headers
    @articles.each do |article|
    CSV.generate_line([article.title, article.content])
    end
    headers = ['Title', 'Content']
    CSV.generate_line headers
    @comments.each do |comment|
    CSV.generate_line([comment.content])
    end
  end
  
  def self.import(file)
    
    spreadsheet = open_spreadsheet(file)
    page_article = spreadsheet.sheet('Articles')

    (2..page_article.last_row).each do |no_row|
      @article = 
        article_new = Article.new
        article_new.title = page_article.row(no_row)[0]
        article_new.content = page_article.row(no_row)[1]
        article_new.published = page_article.row(no_row)[3]
        article_new.save(validate:false)
    end

    page_comment = spreadsheet.sheet('Comments')
    (2..page_comment.last_row).each do |no_row|
      @comments = Comment.create(
        article_id: @article.id,
        user_id: page_comment.row(no_row)[1],
      content: page_comment.row(no_row)[2])
    end

  end
  def self.import_csv(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      article = find_by_id(row["id"]) || new
      article.attributes = row.to_hash.slice(*accessible_attributes)
      article.save!
    end
  end
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
     when '.csv' then Roo::Csv.new(file.path, packed: false, file_warning: :ignore)
     when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
     when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
     else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
