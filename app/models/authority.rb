class Authority < ActiveRecord::BaseWithoutTable
  
  column :type_id,     :string
  column :user_id,     :string
  column :lastname,    :string
  column :firstname,   :string
  column :middlename,  :string
  column :position,    :string
  
  validates_presence_of :type_id
end