module DocumentMenuHelper
  
  def contextual_menu
    navigation.ul :html => { :id => :contextual_menu, :class => :tabbed_menu } do |ul|
      ul.li t(:header, :scope => [:shared, :senddocument]), list_senddocuments_path,             :senddocuments => :list
      #ul.li "Регистрационные карточки", licenses_organization_path,    :organizations => :licenses
      ul.li t(:header, :scope => [:shared, :authority]), warrant_senddocuments_path,  :senddocuments => :warrant
      ul.li t(:header_message, :scope => [:shared, :senddocument]), message_senddocuments_path,     :senddocuments => :message
    end
  end

end
