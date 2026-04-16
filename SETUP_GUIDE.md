# 🚀 Гайд по запуску и тестированию Colibri Social Network

## 📋 Содержание
1. [Предварительные требования](#предварительные-требования)
2. [Установка и настройка](#установка-и-настройка)
3. [Запуск приложения](#запуск-приложения)
4. [Тестирование](#тестирование)
5. [Архитектура приложения](#архитектура-приложения)
6. [Исправленные баги](#исправленные-баги)

---

## 📦 Предварительные требования

### Обязательно установить:
1. **Flutter SDK** (версия 2.15.1+)
   ```bash
   # Проверить установку
   flutter --version
   ```

2. **Android Studio** (для Android разработки)
   - Установить Android SDK (API 33+)
   - Установить эмулятор Android

3. **Xcode** (для iOS разработки, только на macOS)
   - Установить iOS Simulator

4. **Git** (для контроля версий)

### Проверить установку:
```bash
flutter doctor
```

Все должно быть зеленым ✅

---

## 🔧 Установка и настройка

### Шаг 1: Клонировать/открыть проект
```bash
cd "Script Files"
```

### Шаг 2: Установить зависимости
```bash
flutter pub get
```

### Шаг 3: Сгенерировать код (ВАЖНО!)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Это генерирует:
- `injection.config.dart` (Dependency Injection)
- `routes.gr.dart` (Навигация)
- Другие файлы через `@injectable` и `@immutable` аннотации

### Шаг 4: Настроить переменные окружения

Создать файл `.env` в корне проекта (скопировать из `.env.example`):
```bash
cp .env.example .env
```

Отредактировать `.env`:
```
API_BASE_URL=https://www.colibri-sm.ru/mobile_api/
GOOGLE_CLIENT_ID=your_actual_google_client_id
FACEBOOK_APP_ID=your_actual_facebook_app_id
DEBUG_LOGGING=true
```

⚠️ **ВАЖНО**: Никогда не коммитить `.env` с реальными ключами!

---

## 🎮 Запуск приложения

### На Android эмуляторе:
```bash
# Запустить эмулятор (если не запущен)
emulator -avd Pixel_4_API_33

# Запустить приложение
flutter run
```

### На iOS симуляторе (macOS):
```bash
# Запустить симулятор
open -a Simulator

# Запустить приложение
flutter run -d "iPhone 14"
```

### На физическом устройстве:
```bash
# Подключить устройство через USB
# Включить Developer Mode

# Список доступных устройств
flutter devices

# Запустить на конкретном устройстве
flutter run -d <device_id>
```

### Запуск в режиме Release (для тестирования производительности):
```bash
flutter run --release
```

---

## 🧪 Тестирование

### Тестовые учетные данные:

**Email/Password вход:**
```
Email: test@example.com
Password: Test@1234
```

**Требования к паролю (обновлено):**
- Минимум 12 символов (было 8)
- Минимум 1 заглавная буква (A-Z)
- Минимум 1 строчная буква (a-z)
- Минимум 1 цифра (0-9)
- Минимум 1 спецсимвол (!@#$%^&*)

### Основные сценарии тестирования:

#### 1️⃣ Авторизация
- [ ] Вход через email/пароль
- [ ] Вход через Google
- [ ] Вход через Facebook
- [ ] Регистрация нового пользователя
- [ ] Восстановление пароля
- [ ] Выход из приложения

#### 2️⃣ Лента (Feed)
- [ ] Загрузка постов
- [ ] Скролл вниз (пагинация)
- [ ] Лайк поста
- [ ] Комментарий к посту
- [ ] Поделиться постом
- [ ] Сохранить пост в закладки

#### 3️⃣ Создание поста
- [ ] Создать текстовый пост
- [ ] Добавить фото
- [ ] Добавить видео
- [ ] Создать опрос
- [ ] Добавить эмодзи
- [ ] Опубликовать пост

#### 4️⃣ Чат (Messages)
- [ ] Открыть список чатов
- [ ] Отправить сообщение
- [ ] Получить уведомление
- [ ] Отправить фото в чат
- [ ] Удалить сообщение

#### 5️⃣ Профиль
- [ ] Просмотр профиля
- [ ] Редактирование профиля
- [ ] Загрузка аватара
- [ ] Изменение пароля
- [ ] Просмотр подписчиков/подписок

#### 6️⃣ Безопасность (новое)
- [ ] Проверить что токены НЕ логируются
- [ ] Проверить что пароли НЕ видны в логах
- [ ] Проверить что приложение работает только по HTTPS
- [ ] Проверить что чувствительные данные в secure storage

### Как смотреть логи:

```bash
# Все логи
flutter logs

# Только ошибки
flutter logs --grep "ERROR"

# Логи конкретного приложения
flutter logs -c
```

---

## 🏗️ Архитектура приложения

### Clean Architecture + BLoC Pattern

```
lib/
├── main.dart                          # Точка входа
├── core/                              # Общие утилиты
│   ├── config/                        # Конфигурация
│   │   └── app_config.dart           # Переменные окружения
│   ├── common/
│   │   ├── api/                       # API клиент
│   │   ├── logger/                    # Безопасное логирование
│   │   ├── secure_storage/            # Зашифрованное хранилище
│   │   └── validators/                # Валидаторы
│   ├── datasource/                    # Локальное хранилище
│   ├── di/                            # Dependency Injection
│   ├── routes/                        # Навигация
│   └── theme/                         # Темы и стили
│
├── features/                          # Функции приложения
│   ├── authentication/                # Авторизация
│   │   ├── data/                      # Слой данных
│   │   │   ├── datasource/            # API запросы
│   │   │   ├── models/                # JSON модели
│   │   │   └── repository/            # Реализация репозитория
│   │   ├── domain/                    # Бизнес логика
│   │   │   ├── entity/                # Сущности
│   │   │   ├── repository/            # Интерфейсы
│   │   │   └── usecase/               # Операции
│   │   └── presentation/              # UI
│   │       ├── bloc/                  # BLoC/Cubit
│   │       ├── pages/                 # Экраны
│   │       └── widgets/               # Компоненты
│   │
│   ├── feed/                          # Лента постов
│   ├── posts/                         # Создание постов
│   ├── messages/                      # Чат
│   └── profile/                       # Профиль
│
└── assets/                            # Ресурсы
    ├── translations/                  # Локализация
    └── images/                        # Изображения
```

### Поток данных:

```
UI (Widget)
    ↓
BLoC/Cubit (Управление состоянием)
    ↓
UseCase (Бизнес логика)
    ↓
Repository (Интерфейс)
    ↓
DataSource (API/Local)
    ↓
API/Database
```

### Пример: Получение ленты постов

1. **UI** вызывает `FeedCubit.loadFeed()`
2. **BLoC** вызывает `GetFeedUseCase.call()`
3. **UseCase** вызывает `FeedRepository.getFeed()`
4. **Repository** вызывает `RemoteDataSource.getFeed()`
5. **DataSource** делает HTTP запрос через `ApiHelper`
6. **API** возвращает JSON
7. **DataSource** парсит JSON в модели
8. **Repository** преобразует модели в entities
9. **BLoC** эмитит новое состояние
10. **UI** перестраивается с новыми данными

---

## 🔒 Исправленные баги

### 1. Безопасность хранилища
**Было:** Токены в SharedPreferences без шифрования
**Исправлено:** Создан `SecureStorageService` с flutter_secure_storage

### 2. Логирование чувствительных данных
**Было:** 50+ print() выводили токены, пароли, ID
**Исправлено:** Создан `AppLogger` с условным логированием

### 3. Токены в URL
**Было:** session_id передавался в query параметрах
**Исправлено:** Токены только в Authorization header

### 4. HTTP вместо HTTPS
**Было:** NSAllowsArbitraryLoads = true в iOS
**Исправлено:** Отключено, разрешен только HTTPS

### 5. Слабая валидация пароля
**Было:** 8 символов, только буквы и цифры
**Исправлено:** 12 символов, требует спецсимволы

### 6. Устаревшие SDK версии
**Было:** minSdkVersion 21, targetSdkVersion 30
**Исправлено:** minSdkVersion 24, targetSdkVersion 33

### 7. Открытые API ключи
**Было:** Facebook ID в Info.plist
**Исправлено:** Перемещены в переменные окружения

---

## 📝 Следующие шаги

1. **Добавить flutter_secure_storage в pubspec.yaml**
   ```yaml
   dependencies:
     flutter_secure_storage: ^8.0.0
   ```

2. **Обновить DI контейнер** для использования SecureStorageService

3. **Добавить token refresh механизм**

4. **Добавить session timeout**

5. **Добавить certificate pinning**

6. **Добавить биометрическую авторизацию**

---

## 🆘 Решение проблем

### Ошибка: "Flutter SDK not found"
```bash
flutter config --android-sdk /path/to/android/sdk
```

### Ошибка: "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Ошибка: "Pod install failed" (iOS)
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
```

### Приложение не запускается
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 📞 Контакты и поддержка

Если возникли проблемы:
1. Проверить логи: `flutter logs`
2. Очистить кэш: `flutter clean`
3. Пересоздать код: `flutter pub run build_runner build`
4. Перезагрузить эмулятор/устройство

---

**Версия документации:** 1.0
**Последнее обновление:** 2024
