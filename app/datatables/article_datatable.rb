class ArticleDatatable < AjaxDatatablesRails::Base
  include Rails.application.routes.url_helpers
  def_delegators :@view, :link_to, :vendor_skus_path, :vendor_path

  
  include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator
  
  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.name'
    @sortable_columns ||= ['articles.title','articles.content']
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.name'
    @searchable_columns ||= ['articles.title','articles.content' ]
  end

  private

  def data
    records.map do |record|
      [
        record.title,
        record.content.truncate(20),
        "<img src='#{record.image.url(:thumb)}' alt='' class='img-responsive'>",
        "#{link_to("Show", record,:class=>"")}"+"&nbsp;#{link_to 'Edit', edit_article_path(record)}"+"&nbsp;#{link_to 'Destroy', article_path(record.id), method: :delete, data: { confirm: 'Are you sure?' }}"
       # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    Article.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
