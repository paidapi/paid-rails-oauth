# Paid Rails OAuth Sample

This repository provides sample for Rails application that authenticates against Paid OAuth2 provider.

## OAuth App
Create your own Paid Application in [developer portal](https://developer.paidlabs.com). Use App ID and Secret to setup Environment variables.

## Environment
Setup these **required** environment variables:

```
PAID_APP_ID: # use info from Developer app
PAID_SECRET: # use info from Developer app
```

You can also setup **optional** environment variables:

```
PAID_OAUTH_URL: # defaults to https://auth.paidlabs.com
PAID_API_URL: # defaults to https://api.paidlabs.com
```

## Database
Application uses Postgresql. You can find more details in `config/database.yml`

## Development
Run `bundle exec rails s`

In [developer portal](https://developer.paidlabs.com) configure your apps `redirect_uri` to `http://localhost:3000/users/auth/paid_connect/callback`

## API
You can find additional resources in [API documentation](http://docs.paidlabs.com/)
