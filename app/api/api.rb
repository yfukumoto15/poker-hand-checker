class Api < Grape::API
  format :json

  namespace :v1 do
    mount V1::PokerApi
  end
end 