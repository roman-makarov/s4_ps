class Senddocument < ActiveRecord::BaseWithoutTable
  
  column :type_id,  :string
  column :document, :string
  
  validates_presence_of :type_id, :document
end