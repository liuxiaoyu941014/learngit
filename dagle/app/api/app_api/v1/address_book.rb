module AppAPI::V1
  class AddressBook < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :address_books do

      desc "创建地址簿" do
        success AppAPI::Entities::AddressBook
      end
      params do
        requires :name, type: String, desc: '收货人名字'
        requires :mobile_phone, type: String, desc: '电话'
        requires :full_address, type: String, desc: '收货地址'
      end
      post do
        authenticate!
        address_book = current_user.address_books.new(city: '', street: '')
        address_book.name = params[:name]
        address_book.mobile_phone = params[:mobile_phone]
        address_book.full_address = params[:full_address]
        error! address_book.errors unless address_book.save
        present address_book, with: AppAPI::Entities::AddressBook
      end

      desc "修改地址簿" do
        success AppAPI::Entities::AddressBook
      end
      params do
        requires :id, type: Integer, desc: '地址薄ID'
        requires :name, type: String, desc: '收货人名字'
        requires :mobile_phone, type: String, desc: '电话'
        requires :full_address, type: String, desc: '收货地址'
      end
      put ':id' do
        authenticate!
        address_book = ::AddressBook.find(params[:id])
        address_book.name = params[:name]
        address_book.mobile_phone = params[:mobile_phone]
        address_book.full_address = params[:full_address]
        error! address_book.errors unless address_book.save
        present address_book, with: AppAPI::Entities::AddressBook
      end

      desc '查看地址簿' do
        success AppAPI::Entities::AddressBook
      end
      get 'my' do
        authenticate!
        present current_user.address_books, with: AppAPI::Entities::AddressBook
      end

      desc '删除地址薄' do
        success AppAPI::Entities::AddressBook
      end
      params do
        requires :id, type: Integer, desc: '地址薄ID'
      end
      delete ':id' do
        authenticate!
        address_book = ::AddressBook.find(params[:id]).destroy
        present address_book, with: AppAPI::Entities::AddressBook
      end

    end # end of resources
  end
end
