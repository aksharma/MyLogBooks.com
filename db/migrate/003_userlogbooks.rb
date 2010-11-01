class Userlogbooks < ActiveRecord::Migration
  def self.up
    create_table :userlogbooks do |t|
      t.integer :user_id
      t.string	:username,
      			:student_num,
      			:ppl_num
      t.date  	:dob, 				#dob: date of birth
      			:last_medical,
      			:last_bfr,			#bfr: biennial flight review
      			:last_ipc,			#ipc: instrument prof check
      			:last_pic,
      			:last_night
      t.text :address,
      		 :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :userlogbooks
  end
end
