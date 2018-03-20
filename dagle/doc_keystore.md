# 什么是系统参数

系统参数用于存储系统公共访问的常量值，提供一个统一的方法方便程序员调用，同时也方便后台管理维护。

系统参数都存储在Model: Keystore里面。

# Keystore提供五个方法

  1. Keystore.put(key, value)

    用户存储键值对

  2. Keystore.get(key)

    通过key,返回对于的Keystore实例

  3. Keystore.value_for(key)

    通过key, 返回对应的value值

  4. Keystore.increment_value_for(key, amount = 1)

    对于键的值自增

  5. Keystore.decrement_value_for(key, amount = -1)

    对于键的值自减

举例：

<pre>
  Keystore.value_for('cms_template_list')
    => ['default', 'dagle', 'market']
  实际应用：
  = f.input :template, collection: eval(Keystore.value_for('cms_template_names'))

  Keystore.increment_value_for('visit_count')
  Keystore.increment_value_for('visit_count', 3)
</pre>
