module DineromailHelper
 
  def dineromail_form(item_name,amount,options = {})
    options = options.symbolize_keys
    button_image_url = options.delete(:button_image_url) || Dineromail.configuration.button_image_url
    payment_url = options.delete(:payment_url) || Dineromail.configuration.payment_url
    form_options = options.delete(:form) || {}
    form_options[:action] = payment_url
    content_tag(:form, form_options ) do
      dineromail_inputs(item_name,amount,options) +
      content_tag(:input,nil, :type => 'image', :src => button_image_url, :border => '0', :name=> 'submit', :alt=>'Pagar con Dineromail' )
    end
  end
  
  
  def dineromail_inputs(item_name,amount,options = {})
    options = options.symbolize_keys
    logo_url =  options[:logo_url] || Dineromail.configuration.logo_url
    return_url =  options[:return_url] || Dineromail.configuration.return_url
    error_url =  options[:error_url] || Dineromail.configuration.error_url
    message =  options[:message] ? 1 : 0
    account_number =  options[:account_number] || Dineromail.configuration.account_number
    pay_methods = options[:pay_methods] || Dineromail.configuration.pay_methods
    currency = options[:currency] || Dineromail.configuration.currency
      
    html = content_tag(:input,nil, :type => 'hidden', :name => 'NombreItem', :value =>item_name)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'TipoMoneda', :value =>currency)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'PrecioItem', :value =>amount)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'E_Comercio', :value =>account_number)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'NroItem', :value => options[:item_number]) if options.include? :item_number
    html += content_tag(:input,nil, :type => 'hidden', :name => 'image_url', :value =>logo_url)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'DireccionExito', :value => return_url)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'DireccionFracaso', :value => error_url)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'Mensaje', :value => message)
    html += content_tag(:input,nil, :type => 'hidden', :name => 'MediosPago', :value => pay_methods)
    html
  end  
  
  
end

