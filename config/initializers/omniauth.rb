OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '232947433496427', 'a911e68c2ea5a0345a00f103df60c9e9'
  provider :twitter, "pGEmRSmgvm5xzOkbtILJhy8Fc", "cO3sunRbBxHVTcrKhWA6fRd1PgZEtWnD23DmtHwr9ppITnse2q"
end