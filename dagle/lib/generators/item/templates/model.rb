class <%= class_name%> < Item
<%- if attributes.any? -%>
  store_accessor :features, <%= attributes.map { |attr| ":" + attr.name }.join(', ') %>
<%- end -%>
end
