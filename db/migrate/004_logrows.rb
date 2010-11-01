class Logrows < ActiveRecord::Migration
  def self.up
    create_table :logrows do |t|
      t.integer :userlogbook_id,
      			:instr_appr,     #instrument approaches
      			:landings
	  t.date	:flt_date
      t.string	:make_model,
    			:aircraft_ident,
    			:from,			#from airport
    			:dest,			#to airport
    			:remarks
      t.float	:sel,
      			:mel,
      			:xc,
      			:pic_xc,
      			:day,
      			:night,
      			:actual_ifr,
      			:sim_ifr,
      			:dual,
      			:pic,
      			:total
      t.timestamps
    end
  end

  def self.down
    drop_table :logrows
  end
end
