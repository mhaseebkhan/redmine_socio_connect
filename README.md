
============================================================================================================================================
============================================================TWEET BOOK PLUGIN===============================================================
============================================================================================================================================

1.1 Redmine
    =======

    Redmine is a flexible project management web application written using Ruby on Rails framework.

    More details can be found in the doc directory or on the official website www.redmine.org


2.1 Redmine SocioConnect plugin
    ========================

2.2 Why Needed
    ========== 

    Due to the lack of support for multi-provider authentication such as facebook and twitter on redmine.
    This plugin is developed for introducing multi-provider authentication support on redmine. 

2.3 Achieved With
    =============

    The functionality of alternative login on redmine plugin is achieved with 
    
    * omniauth

       OmniAuth is a library that standardizes multi-provider authentication for web applications.
       Visit 'https://github.com/intridea/omniauth' for documentation and source code.

    * omniauth-facebook 
      
       Facebook OAuth2 Strategy for OmniAuth 1.0. This gem is built ontop of omniauth in-order to provide facebook authentication.
       Visit 'https://github.com/mkdynamic/omniauth-facebook' for documentaion and source code.

    * omniauth-twitter

       This gem contains the Twitter strategy for OmniAuth. This gem is built ontop of omniauth in-order to provide twitter authentication.
       Visit 'https://github.com/mkdynamic/omniauth-facebook' for documentaion and source code.

    The above mentioned gems played an important role in developing this plugin.


2.4 Configuration
    =============

    -> Authentication in redmine through Facebook and Twitter similar to existing OpenID Authentication.

    -> Download the plugin to your redmine/plugins directory. 

    -> Be sure to maintain the correct folder name, 'redmine_socio_connect'.

    -> Configure your Facebook and Twitter keys in config/settings.yml.
         facebook:
                   key: 'your fb key'                                 # App ID/API Key
                   secret: 'your fb secret'                           # App secret
         twitter:
                   key: 'your twitter key'                            # Consumer key
                   secret: ' your twitter secret'        	      # Consumer secret
 
    -> Run "rake redmine:plugins:migrate RAILS_ENV=production".
         Runing this command will migrate the database for the redmine plugin.

    -> Restart your redmine as appropriate (e.g., rails s -e production)
         Thus the changes could take effect properly.

    -> Tested on redmine version 2.3.2
         This plugin is tested on the latest release of redmine. Make sure that you have the latest release as well.


3.1 Walkthrough
    ===========
 
3.2 Login
    =====
 
    -> The login popup will have two options for the user. Login with Facebook / Login with Twitter 
    -> Once you login with your facebook account. Allow access to the application via your facebook account.

3.3 Redmine Registeration
    =====================

    -> You will be required to give credentials for redmine registeration.
    -> Fill in the registeration form for redmine.

3.4 Multiple Account Access
    =======================

    -> When you are done with the registeration you will have two accounts which are connected with each other. 
        Redmine Account
        Facebook/Twitter Account 
    -> Latter you can login via redmine and multiple providers.










