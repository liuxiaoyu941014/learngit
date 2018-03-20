require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  it { expect(described_class).to be < Devise::RegistrationsController }
end
