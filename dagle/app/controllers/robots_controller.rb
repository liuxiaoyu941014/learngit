class RobotsController < ActionController::Base
  def index
    render plain: <<-ROBOTS.strip_heredoc
    # See http://www.robotstxt.org/robotstxt.html for documentation on how to use the robots.txt file
    #
    # To ban all spiders from the entire site uncomment the next two lines:
    # User-agent: *
    # Disallow: /
    #{subdomain_entries}
    ROBOTS
  end

  private

  def subdomain_entries
    if CmsSubdomain.matches?(request) && request.subdomain != 'www'
      <<-ROBOTS.strip_heredoc
      Disallow: /
      ROBOTS
    end
  end
end
