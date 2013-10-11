module RedmineSocioConnect
  module Hooks
    class ViewsLayoutsHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})      	
        return stylesheet_link_tag(:socio_connect, :plugin => 'redmine_socio_connect')
      end
    end
  end
end