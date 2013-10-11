module RedmineSocioConnect
  module Patches

    module AccountControllerPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :register, :facebook_and_twitter
        end
      end

      module InstanceMethods

        def socio_connect_authenticate
          auth_hash = request.env['omniauth.auth']

          user_email = nil
          if(auth_hash[:provider]=='twitter')
            user_email = SocioConnect.where(:email => auth_hash[:uid]+'@twitter.com').present?
          else
            if(auth_hash[:provider] == 'facebook')
              user_email = SocioConnect.where(:uid => auth_hash[:uid]).present?
            end
          end
          socio_connect = SocioConnect.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid']) || SocioConnect.create_with_auth_hash(auth_hash)


          user = User.find_or_initialize_by_id(socio_connect.user_id)

          if !user_email
            if user.new_record?

              # Self-registration off
              redirect_to(home_url) && return unless Setting.self_registration?

              session[:auth_socio_id] = socio_connect.id

              return redirect_to :controller => 'account', :action => 'register', :user => user

              case Setting.self_registration
                when '1'
                  register_by_email_activation(user) do
                    onthefly_creation_failed(user)
                  end
                when '3'
                  register_automatically(user) do
                    onthefly_creation_failed(user)
                  end
                else
                  register_manually_by_administrator(user) do
                    onthefly_creation_failed(user)
                  end
              end
              socio_connect.update_attribute :user_id, user.id
            end
          else
            if user.active?
              successful_authentication(user)
            else
              render_error :message => "User not activated by admin"
            end
          end
        end

        def register_with_facebook_and_twitter
          (redirect_to(home_url); return) unless Setting.self_registration? || session[:auth_source_registration]
          if request.get?                                         #on registeration it will be a post request
            session[:auth_source_registration] = nil
            @user = User.new(:language => current_language.to_s)
          else
            user_params = params[:user] || {}
            @user = User.new
            @user.safe_attributes = user_params
            @user.admin = false
            @user.register

            socio_connect_tuple = SocioConnect.find(session[:auth_socio_id])

            if session[:auth_source_registration]      #when loggin in and admin has allowed it
              @user.activate
              @user.login = session[:auth_source_registration][:login]
              @user.auth_source_id = session[:auth_source_registration][:auth_source_id]
              if @user.save
                session[:auth_source_registration] = nil
                self.logged_user = @user
                flash[:notice] = l(:notice_account_activated)
                redirect_to my_account_path
              end
            else
              @user.login = params[:user][:login]
              unless user_params[:identity_url].present? && user_params[:password].blank? && user_params[:password_confirmation].blank?
                @user.password, @user.password_confirmation = user_params[:password], user_params[:password_confirmation]
              end

              case Setting.self_registration
                when '1'
                  register_by_email_activation(@user)
                when '3'
                  register_automatically(@user)
                else
                  register_manually_by_administrator(@user)
              end

              socio_connect_tuple.update_attribute :user_id, @user.id
            end
          end
        end


      end

    end # end Account Controller patch

  end
end

unless AccountController.included_modules.include?(RedmineSocioConnect::Patches::AccountControllerPatch)
  AccountController.send(:include, RedmineSocioConnect::Patches::AccountControllerPatch)
end