class Senddocument < Base
  
  column :type_id,  :string
  column :document, :string
  #column :sendDocument, :button, nil,      nil,           {'name' => I18n.t(:send_button, :scope => [:shared, :senddocument])}
  
  validates_presence_of :type_id, :document
end