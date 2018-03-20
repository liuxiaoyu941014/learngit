class Comment::EntryCell < Comment::BaseCell
  property :comments
  def show
    render
  end
end
