# README

API for techideation

## Swagger docs

Generate docs using command: `SD_LOG_LEVEL=1 SWAGGER=1 rake swagger:docs`
Watch generated documentation here: http://localhost:3000/swagger/dist/index.html?url=/apidocs/api-docs.json

# 2-factors sign in, phone varification

In test mode we can use pin code "1111" - it is always valid.
For testing different gateway responces we can use next numbers:
https://www.twilio.com/docs/api/rest/test-credentials#test-sms-messages-parameters-To