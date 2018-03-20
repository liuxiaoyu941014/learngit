module Favorite
  module Helpers
    def render_favorite(resource, path:)
      cell(Favorite::EntryCell, resource, path: path).()
    end
  end
end