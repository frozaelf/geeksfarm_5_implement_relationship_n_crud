class Comment < ActiveRecord::Base
    before_create :default_status

        belongs_to :article

        belongs_to :user

        validates :content, presence: true, length: { minimum: 10 }


        def default_status

            self.status = "not active"

        end         
        #name relation must singular

        belongs_to :article
        def self.to_csv(options = {})
          CSV.generate(options) do |csv|
            csv << column_names
             all.each do |comment|
              csv << comment.attributes.values_at(*column_names)
            end
          end
        end
end
