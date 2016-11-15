module TokenAuthenticable
  def to_token_payload
    { sub: id, email: email, type: 'Account' }
  end

  def self.from_token_payload(payload)
    payload[type].constantize.find(payload['id'])
  end
end
