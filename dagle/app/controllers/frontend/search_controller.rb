class Frontend::SearchController < Frontend::BaseController
  def search_result
    if params[:type] == nil || params[:type] == 'cms_pages'
      @filter_colums = %w(title description)
      @search_results = build_query_filter(Cms::Page.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    end

    if params[:type] == 'sites'
      @filter_colums = %w(title)
      @search_results = build_query_filter(Site.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    end

    if params[:type] == 'products'
      @filter_colums = %w(name)
      @search_results = build_query_filter(Product.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    end

  end
end
