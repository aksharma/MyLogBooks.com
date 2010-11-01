class Userlogbook < ActiveRecord::Base
	belongs_to :user
	has_many :logrows, :dependent => :destroy
end
