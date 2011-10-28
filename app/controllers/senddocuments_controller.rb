class SenddocumentsController < ApplicationController
  include SenddocumentsHelper
  
  helper :members_menu, :document_menu
  
  def message
    
  end
  
  def form
    if !session['form'].nil?
      @senddocument = session.delete('form')
    else
      @senddocument = Senddocument.new
    end
    if !session['complete_message'].nil?
      @complete_message = session['complete_message']
      session.delete('complete_message')
    end
    S4::SendedFormType.scope = {'sended_form_kind' => '5'}
    @document_types = S4::SendedFormType.all_with_scope(s4_user)
  end
  
  def create
    senddocument = params[:senddocument]
    @senddocument = Senddocument.new(senddocument)
    if @senddocument.valid?
      send_document(senddocument)
      session['complete_message'] = t(:complete_message, :scope => [:shared, :senddocument])
    else
      session['form'] = @senddocument
    end
    redirect_to :action => 'form'
  end
  
  def list
		regex = /\d{2}\.\d{2}\.\d{4}/
    time_now = Time.now
    
    @documentfilter = params[:documentfilter]
    @documentfilter = Documentfilter.new(@documentfilter)
    
    @doc_params = parse_params_not_nil(@documentfilter)
    
    

    S4.site = 'http://s4-beta.micex.ru/S4XmlRpcService'
    @sessionId = S4.connection.call("s4.openSession", I18n.locale)
    
    S4::SendedForm.scope = @doc_params
    @documentListing = S4::SendedForm.all_with_scope(s4_user)
    
    S4::SendedFormType.scope = {'sended_form_kind' => '5'}
    @typesListing = S4::SendedFormType.all_with_scope(s4_user)
    
    @senderListing = S4::SendEmail.all_with_scope(s4_user)

    
    #@documentList = S4.connection.call("s4.getResource", @sessionId, 'sended_form', "8de0f94c-536a-40be-af22-9571649b3616", @doc_params, '');
    #@documentList = S4::Resource.parse_many(@documentList)
    
    #@senderList = S4.connection.call("s4.getResource", @sessionId, 'sender_email', "8de0f94c-536a-40be-af22-9571649b3616");
    #@senderList = S4::Resource.parse_many(@senderList)
    
   # @typesList = S4.connection.call("s4.getResource", @sessionId, 'sended_form_type', "8de0f94c-536a-40be-af22-9571649b3616", {
    #  'sended_form_kind' => '5'        
    #}, '');
    #@typesList = S4::Resource.parse_many(@typesList)
  end
  
  def index
    
  end
  
  def warrant
    
  end
end
