class Charge < ActiveRecord::Base
	store :transaction, coder: JSON
end
