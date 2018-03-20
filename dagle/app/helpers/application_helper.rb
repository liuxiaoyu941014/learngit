module ApplicationHelper
  # Check current page by route paths
  # == Usage
  #  page?('admin/products') => check controller path is 'admin/products'
  #  page?('admin/products#index') => check controller path is 'admin/products' and action_name is 'index'
  #  page?('admin/products#show?id=1') => check controller_path is 'admin/products', action_name is 'show' and id is 1
  #
  # @param *paths [Array] route path
  # @return True or False
  def page?(*paths)
    !!paths.find do |path|
      others, _args = path.split('?')
      _controller, _action = others.split('#')

      flag = true
      flag = false if _args && !_args.split('&').all? { |arg| k, v = arg.split('='); params[k].to_s == v.to_s }
      flag = false if _action && action_name != _action
      flag = false if _controller != controller_path
      flag = true if path == request.fullpath
      flag
    end
  end

  # get random img use in login interface or banner
  # == Usage
  #  image_tag(rand_banner_img)
  def rand_banner_img
    [
      'http://song-dev.qiniudn.com/g0.jpg',
      'http://song-dev.qiniudn.com/g1.jpg',
      'http://song-dev.qiniudn.com/g2.jpg',
      'http://song-dev.qiniudn.com/g3.jpg',
      'http://song-dev.qiniudn.com/g4.jpg',
      'http://song-dev.qiniudn.com/g5.jpg',
      'http://song-dev.qiniudn.com/g6.jpg'
    ].sample
  end

  # class="bg-blue"
  def rand_bg_color
    [ 'silver', 'silver-darker',
      'black', 'black-darker',
      'grey', 'grey-darker',
      'red', 'red-darker', 'red-lighter',
      'orange', 'orange-darker', 'orange-lighter',
      'green', 'green-darker', 'green-lighter',
      'yellow', 'yellow-darker',
      'blue', 'blue-darker', 'blue-lighter',
      'aqua', 'aqua-darker', 'aqua-lighter',
      'purple', 'purple-darker', 'purple-lighter',
    ].sample
  end

  def rand_color
    ['default', 'primary', 'success', 'info', 'warning', 'danger'].sample
  end

end
