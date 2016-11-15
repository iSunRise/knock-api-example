module RequestHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def auth_header_for(resource)
    token = Knock::AuthToken.new(payload: resource.to_token_payload).token
    { 'Authorization' => "Bearer #{token}" }
  end
end
