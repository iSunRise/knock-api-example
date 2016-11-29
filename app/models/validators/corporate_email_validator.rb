class CorporateEmailValidator < ActiveModel::Validator
  def validate(record)
    return if public_domains.exclude?(record.email.to_s.split('@').last)
    record.errors[:email] << 'Email must belongs to company (no shared serices)'
  end

  private

  def public_domains
    %w(me.com icloud.com gmail.com mail.com mail.ru mail.ua i.ua outlook.com
       hotmail.com yahoo.com hotmail.co.uk)
  end
end
