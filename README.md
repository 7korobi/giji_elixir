# work MEMO

```
mix phoenix.gen.json Card    cards                                 book_id:integer part_id:integer potof_id:integer name:string state:integer
mix phoenix.gen.json Potof   potofs      user_id:references:users  book_id:integer part_id:integer section_id:integer name:string job:string sign:string face_id:string state:integer

mix phoenix.gen.json Book    books       user_id:references:users  book_id:integer part_id:integer                                    name:string
mix phoenix.gen.json Part    parts       user_id:references:users  book_id:integer part_id:integer section_id:integer                 name:string
mix phoenix.gen.json Section sections    user_id:references:users  book_id:integer part_id:integer section_id:integer                 name:string
mix phoenix.gen.json Phase   phases      user_id:references:users  book_id:integer part_id:integer phase_id:integer chat_id:integer name:string
mix phoenix.gen.json Chat    chats       user_id:references:users  book_id:integer part_id:integer section_id:integer phase_id:integer chat_id:integer potof_id:integer to:string style:string log:string

chapter
section

  field :zapcount,  type: Integer
  field :clearance

  field :select
  field :live
  field :deathday,  type: Integer

  field :overhear,    type: Array

  field :bonds,       type: Array
  field :pseudobonds, type: Array

  field :love
  field :sheep
  field :pseudolove

  field :point, type: Hash
  field :say,   type: Hash
  field :timer, type: Hash

  index({story_id: 1})
  index({sow_auth_id: 1, story_id: 1}, {unique: 1})

  default_scope -> { order_by(:pno.asc) }


:integer, :float, :decimal, :boolean, :map, :string, :array, :references, :text, :date, :time, :naive_datetime, :utc_datetime, :uuid, :binary

```


# install

```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix local.phoenix
mix deps.get
npm install
```

and mariadb install.

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
