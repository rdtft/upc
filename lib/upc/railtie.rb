require 'upc/upc_helper'

module Upc
  class Railtie < Rails::Railtie
    initializer 'upc.view_helpers' do |app|
      ActionView::Base.send :include, Upc::UpcHelper
    end
  end
end
