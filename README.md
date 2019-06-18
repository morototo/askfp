# バージョン
- Rails version: 5.2.3
- Ruby version: 2.6.3
- Database adapter: mysql
- MySQL version: 5.7.26


# 環境構築

## 前提
- Docker,Docker Composeがインストールされていること
- Docker version 18.06.0-ce
- Docker Compose version 1.22.0

```ruby
docker-compose.ymlを修正してください。
$ vi docker/docker-compose.yml

左部分をaskfpがあるパスに書き換えてください。
- /to/your/path/askfp/:/home/git/askfp/:z

※ git cloneしたディレクトリパスが /var/www/ の場合下記に書き換え
- /var/www/askfp/askfp/:/home/git/askfp/:z

$ cd docker
$ docker-compose up -d 
$ docker ps #コンテナが作成されていることを確認
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
d75c64cb1b8c        ruby:2.6.3          "irb"                    5 seconds ago       Up 3 seconds        0.0.0.0:3000->3000/tcp              askfp
c55ee8703e64        mysql:5.7           "docker-entrypoint.s…"   42 seconds ago      Up 4 seconds        0.0.0.0:3306->3306/tcp, 33060/tcp   mysqldb
```

```ruby
コンテナ内の作業
$ docker exec -it askfp /bin/bash
$ cd /home/git/askfp
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake default_data:set #初期データ投入
$ bundle exec rails s -b 0.0.0.0 # Rails 起動
```

ブラウザにてlocalhost:3000で表示されるか確認

Heroku URL
https://askfp.herokuapp.com/