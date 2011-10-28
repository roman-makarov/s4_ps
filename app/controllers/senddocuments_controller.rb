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

    @by_date_start = params['by_date_start']
    @by_date_finish = params['by_date_finish']
    @by_type = params['by_type']
    @document_name = params['document_name']
    @by_sender = params['by_sender']

    if @by_date_start == '' || @by_date_start.nil? || @by_date_start !~ regex
			@by_date_start = ''
		end
		if @by_date_finish == '' || @by_date_finish.nil? || @by_date_finish !~ regex
			@by_date_finish = ''
		end
    if @by_type == '' || @by_type.nil?
            @by_type = ''
    end
    if @document_name == '' || @document_name.nil?
            @document_name = ''
    end
    if @by_sender == '' || @by_sender.nil?
            @by_sender = ''
    end

    S4.site = 'http://s4-beta.micex.ru/S4XmlRpcService'
    @sessionId = S4.connection.call("s4.openSession", I18n.locale)

    @doc_params = {
      #'sended_form_status' => '1',
      'start_date' => @by_date_start,
      'end_date' => @by_date_finish,
      'sended_form_kind' => '5',
      'sended_form_type' => @by_type,
      'sender' => @by_sender,
      'name' => @document_name
    }
    
    @doc_params.delete_if {|key, value| value == "" }
                
    @documentList = S4.connection.call("s4.getResource", @sessionId, 'sended_form', "76831d27-6daf-44af-bb73-a72875e9a04f", @doc_params, '')
    @documentList = S4::Resource.parse_many(@documentList)

    @typesList = S4.connection.call("s4.getResource", @sessionId, 'sended_form_type', "76831d27-6daf-44af-bb73-a72875e9a04f", {
      'sended_form_kind' => '5'        
    }, '');
    @typesList = S4::Resource.parse_many(@typesList)

    @senderList = S4.connection.call("s4.getResource", @sessionId, 'sender_email', "76831d27-6daf-44af-bb73-a72875e9a04f");
    @senderList = S4::Resource.parse_many(@senderList)
  end
  
  def index
    
  end
  
  def warrant
    
  end
end
