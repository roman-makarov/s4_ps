class AuthoritiesController < ApplicationController
  include AuthoritiesHelper
  
  helper :members_menu
  
  def index
    if !session['form'].nil?
      @authority = session['form']
      session.delete('form')
    else
      @authority = Authority.new
    end
    @warrant_types = S4::WarrantType.all(s4_user)
    @warrant_agents = S4::WarrantAgent.all(s4_user)
  end
  
  def create
    authority = params[:authority]
    @authority = Authority.new(authority)
    if @authority.valid?
      if authority[:user_id] == ''
        #authority[:user_id] = 2123
        
      end
      S4::WarrantField.scope = {
        'warrant_type_id' => authority['type_id'],
        'agent_id' => authority['user_id']
      }
      @vars = S4::WarrantField.find_with_scope(s4_user).attributes
      Rails.logger.info("vars = #{@vars}")
      send_data render_to_pdf({
        :action => "authority_#{authority[:type_id]}",
        :layout => false }
      ), :filename => "authority_#{authority[:type_id]}"
    else
      session['form'] = @authority
      redirect_to :action => 'index'
    end
  end
end