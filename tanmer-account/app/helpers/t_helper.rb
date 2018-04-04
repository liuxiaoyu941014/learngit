module THelper
  def t_flash(key, options={})
    t_scope(key, :flash, options)
  end

  def t_btn(key, options={})
    t_scope(key, :btn, options)
  end

  def t_menu(key, options={})
    t_scope(key, :menu, options)
  end

  private

  def t_scope(key, scope, options={})
    options.symbolize_keys!
    options[:scope] = scope 
    if options[:default].blank? && key.is_a?(String) && (key[0] == '.')
      options[:default] = t("#{scope}#{key}")
    end
    if (model=options.delete(:model))
      options[:resource_name] = model.model_name.human
    end
    t(key, options)
  end
end