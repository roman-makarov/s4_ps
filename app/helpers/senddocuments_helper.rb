module SenddocumentsHelper
  
  def send_document(params)
    uploaded = params[:document]
    File.open(Rails.root.join('public', 'uploads', uploaded.original_filename), 'w') do |file|
      file.write(uploaded.read)
    end
    
    file_link = "#{request.env["HTTP_HOST"]}/uploads/#{uploaded.original_filename}"
    scope = {
      'sended_form_type' => params[:type_id],
      'sended_date'      => '12.12.2012',
      'file_id_link'     => file_link,
      'file_id'          => uploaded.original_filename,
      'status'           => '1'
    }
    S4::SendedForm.scope = scope
    Rails.logger.info("sended_document = #{scope.inspect}")
    Rails.logger.info("session = #{S4.session}")
    S4::SendedForm.set_with_scope(s4_user)
  end
  
end
