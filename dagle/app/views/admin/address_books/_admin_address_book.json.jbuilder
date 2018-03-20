json.extract! admin_address_book, :id, :user_id, :name, :gender, :mobile_phone, :city, :street, :house_number, :note, :created_at, :updated_at
json.url admin_address_book_url(admin_address_book, format: :json)
