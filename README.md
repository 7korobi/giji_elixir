# install

```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix local.phoenix
mix deps.get
npm install
psql -U postgres
  alter user giji with password 'giji';
createdb -U postgres giji_elixir_dev --owner=giji
createdb -U postgres giji_elixir_test --owner=giji
```

## 作成時覚書
```
mix phoenix.new giji_elixir
mix phoenix.server
```

# deploy

To start your Phoenix app:

```
mix phoenix.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## OpenID

* https://developers.facebook.com/apps
* https://console.developers.google.com/apis/credentials
* https://github.com/settings/developers

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
