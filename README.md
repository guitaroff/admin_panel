# Админка для управления пользователями приложения и API для мобильных приложений.
Приложение протестировано и выкачено на [heroku](https://admin-panel-and-api.herokuapp.com). Для входа под администратором понадобиться создать админа через `rails db:seed`. В админке можно создавать, просматривать, изменять и удалять пользователей приложения. Админка имеет адаптивный дизайн и отлично смотрится на мобильных устройствах.

### Панель администратора

#### Для создания админа запустить seed(master key спросить у меня или создать свои email/пароль)
```console
rails db:seed
```

### API

#### Для регистрации по почте и паролю:

```console
POST https://admin-panel-and-api.herokuapp.com/api/v1/users
{
  "user": {
    "email": "andrey@admin-panel.com",
    "password": "123456",
    "password_confirmation": "123456"
  }
}
```

#### Логин и получение токена:

```console
POST https://admin-panel-and-api.herokuapp.com/api/v1/sessions
{
  "email": "andrey@admin-panel.com",
  "password": "123456"
}
```
#### Просмотр своего аккаунта:

```console
GET https://admin-panel-and-api.herokuapp.com/api/v1/account
{
  "user_email": "andrey@admin-panel.com",
  "user_token": "KdX1h9fmauyaMs8zRsEH"
}
```

#### Изменение данных(имя):

```console
PATCH https://admin-panel-and-api.herokuapp.com/api/v1/account
{
  "user_email": "andrey@admin-panel.com",
  "user_token": "KdX1h9fmauyaMs8zRsEH",
  "user": {
    "name": "Олег"
  }
}
```
#### Загрузка/изменение аватарки:

```console
PATCH https://admin-panel-and-api.herokuapp.com/api/v1/account/avatar_upload
Multipart form:
{
  "user_email": "andrey@admin-panel.com",
  "user_token": "KdX1h9fmauyaMs8zRsEH",
  "avatar": "Обзор файла..."
}
```

#### Просмотр всех пользователей:

```console
GET https://admin-panel-and-api.herokuapp.com/api/v1/users
{
  "user_email": "andrey@admin-panel.com",
  "user_token": "KdX1h9fmauyaMs8zRsEH"
}
```

#### Просмотр конкретного пользователя:

```console
GET https://admin-panel-and-api.herokuapp.com/api/v1/users/1
{
  "user_email": "andrey@admin-panel.com",
  "user_token": "KdX1h9fmauyaMs8zRsEH"
}
```
