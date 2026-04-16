# ⚡ Быстрый старт - Запуск Colibri за 5 минут

## 🎯 Цель
Запустить приложение социальной сети на эмуляторе/устройстве и протестировать основные функции.

---

## 📋 Требования

### Обязательно установить:
- **Flutter SDK** (3.0+) - https://flutter.dev/docs/get-started/install
- **Dart SDK** (встроен в Flutter)
- **Android Studio** (для Android) или **Xcode** (для iOS)
- **Git** (для версионирования)

### Проверить установку:
```bash
flutter doctor
```

Должно быть зелено ✅ для платформы, на которой хочешь разрабатывать.

---

## 🚀 Шаг 1: Подготовка (2 минуты)

### 1.1 Открой терминал в папке проекта
```bash
cd "Script Files"
```

### 1.2 Очисти кэш
```bash
flutter clean
```

### 1.3 Загрузи зависимости
```bash
flutter pub get
```

### 1.4 Сгенерируй код (для BLoC, Routes, Models)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Это может занять 1-2 минуты. Жди завершения.**

---

## 📱 Шаг 2: Запуск приложения (1 минута)

### Вариант A: На Android эмуляторе
```bash
flutter run
```

### Вариант B: На iOS симуляторе (только на Mac)
```bash
flutter run -d "iPhone 14"
```

### Вариант C: На реальном устройстве
1. Подключи устройство USB кабелем
2. Включи режим разработчика (Developer Mode)
3. Разреши отладку (USB Debugging)
4. Выполни:
```bash
flutter run
```

**Приложение должно запуститься за 30-60 секунд.**

---

## 🧪 Шаг 3: Первое тестирование (2 минуты)

### 3.1 Экран авторизации
Ты увидишь экран входа. Используй тестовые данные:

```
Email:    test@example.com
Password: Test@1234
```

### 3.2 Нажми "Sign In"
Приложение подключится к API и загрузит данные.

### 3.3 Проверь основные экраны
- **Home** - Лента постов
- **Create** - Создание поста
- **Messages** - Чат
- **Profile** - Профиль пользователя

---

## 🔍 Шаг 4: Проверка логов (1 минута)

### Открой логи в реальном времени:
```bash
flutter logs
```

Ты увидишь:
- ✅ Успешные запросы к API
- ⚠️ Предупреждения
- ❌ Ошибки (если есть)

### Ищи в логах:
```
[INFO] API Request: GET /feed
[INFO] API Response: 200 OK
[INFO] User logged in: test@example.com
```

---

## 🛠️ Шаг 5: Горячая перезагрузка (для разработки)

### Во время разработки используй:
```bash
r  - Горячая перезагрузка (быстро)
R  - Полная перезагрузка (медленнее)
q  - Выход
```

**Горячая перезагрузка** сохраняет состояние приложения и перезагружает только измененный код.

---

## 📊 Что происходит под капотом?

### Архитектура приложения:

```
┌─────────────────────────────────────────┐
│         PRESENTATION LAYER              │
│  (UI Widgets + BLoC State Management)   │
│                                         │
│  ├─ AuthScreen (Вход/Регистрация)      │
│  ├─ FeedScreen (Лента постов)          │
│  ├─ CreatePostScreen (Создание поста)  │
│  ├─ ChatScreen (Чат)                   │
│  └─ ProfileScreen (Профиль)            │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│         DOMAIN LAYER                    │
│  (Бизнес логика - UseCase)              │
│                                         │
│  ├─ LoginUseCase                        │
│  ├─ GetFeedUseCase                      │
│  ├─ CreatePostUseCase                   │
│  ├─ SendMessageUseCase                  │
│  └─ UpdateProfileUseCase                │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│         DATA LAYER                      │
│  (API + Local Storage)                  │
│                                         │
│  ├─ ApiDataSource (HTTP запросы)        │
│  ├─ LocalDataSource (SharedPreferences) │
│  └─ Repository (Интеграция)             │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│         CORE LAYER                      │
│  (Утилиты, конфиг, DI)                  │
│                                         │
│  ├─ ApiHelper (HTTP клиент)             │
│  ├─ AppConfig (Конфигурация)            │
│  ├─ AppLogger (Логирование)             │
│  ├─ SecureStorage (Зашифрованное хранилище) │
│  └─ DI Container (Dependency Injection) │
└─────────────────────────────────────────┘
```

### Поток данных при входе:

```
1. Пользователь вводит email и пароль
   ↓
2. AuthScreen отправляет данные в AuthCubit
   ↓
3. AuthCubit вызывает LoginUseCase
   ↓
4. LoginUseCase вызывает AuthRepository
   ↓
5. AuthRepository отправляет HTTP запрос через ApiHelper
   ↓
6. API возвращает токен и данные пользователя
   ↓
7. AuthRepository сохраняет токен в SecureStorage
   ↓
8. AuthCubit обновляет состояние (Authenticated)
   ↓
9. UI перенаправляет на FeedScreen
   ↓
10. FeedScreen загружает ленту постов
```

---

## 🔐 Безопасность

### Что защищено:
- ✅ Токены хранятся в зашифрованном хранилище (Keychain/EncryptedSharedPreferences)
- ✅ Все запросы идут по HTTPS (TLS 1.2+)
- ✅ Пароли требуют 12 символов + спецсимволы
- ✅ Логирование не содержит чувствительных данных
- ✅ Токены передаются только в Authorization header

---

## 🐛 Если что-то не работает

### Ошибка: "Flutter SDK not found"
```bash
flutter doctor
# Установи Flutter SDK если его нет
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

### Ошибка: "Build runner failed"
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Приложение зависает
```bash
# Останови приложение (Ctrl+C)
flutter clean
flutter run
```

---

## 📚 Дальше

После успешного запуска:

1. **Прочитай [ARCHITECTURE.md](./ARCHITECTURE.md)** - Поймешь как устроено приложение
2. **Прочитай [TESTING_GUIDE.md](./TESTING_GUIDE.md)** - Как тестировать все функции
3. **Прочитай [CUSTOMIZATION_GUIDE.md](./CUSTOMIZATION_GUIDE.md)** - Как переделать под себя
4. **Прочитай [SECURITY_FIXES.md](./SECURITY_FIXES.md)** - Какие баги были исправлены

---

## ✅ Чек-лист

- [ ] Flutter установлен (`flutter doctor` зелено)
- [ ] Проект очищен (`flutter clean`)
- [ ] Зависимости загружены (`flutter pub get`)
- [ ] Код сгенерирован (`build_runner build`)
- [ ] Приложение запущено (`flutter run`)
- [ ] Вход работает (test@example.com / Test@1234)
- [ ] Логи видны (`flutter logs`)
- [ ] Основные экраны открываются

**Если все ✅ - ты готов к разработке! 🚀**

---

**Версия:** 1.0
**Дата:** 2024
**Статус:** ✅ Готово
