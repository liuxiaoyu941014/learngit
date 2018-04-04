Doorkeeper::Application.send :include, Doorkeeper::TanmerApplicationConcern
Doorkeeper::AccessToken.send :include, Doorkeeper::TanmerAccessTokenConcern