module SoftwareCompanies
  class SignUp
    include Interactor::Organizer

    organize ValidateSignUpParams, CreateCompany, CreateAccount # send email
  end
end
