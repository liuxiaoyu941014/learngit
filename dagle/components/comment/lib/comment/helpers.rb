module Comment
  module Helpers
    def render_comments(resource, path:)
      cell(Comment::EntryCell, resource, path: path).()
    end
  end
end