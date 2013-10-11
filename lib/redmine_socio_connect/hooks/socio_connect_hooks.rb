module RedmineSocioConnect
  module Hooks
    class SocioConnectHooks < Redmine::Hook::ViewListener
      render_on :view_layouts_base_html_head, :partial => 'shared/socio_connect'
    end
  end
end