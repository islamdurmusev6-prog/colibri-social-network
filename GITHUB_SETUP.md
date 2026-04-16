# 🚀 GitHub Actions Setup - Автоматическая сборка и тестирование

## 📌 Что это дает?

С GitHub Actions ты можешь:
- ✅ Автоматически тестировать код при каждом push
- ✅ Автоматически собирать APK и IPA
- ✅ Проверять безопасность и качество кода
- ✅ Развертывать приложение на TestFlight и Google Play
- ✅ Все это БЕЗ локальной установки Flutter!

---

## 🎯 Что уже настроено?

### 1. **flutter-build.yml** - Сборка приложения
Запускается при каждом push в main/develop:
- Устанавливает Flutter
- Загружает зависимости
- Генерирует код (BLoC, Routes)
- Запускает тесты
- Собирает APK (Android)
- Собирает IPA (iOS)
- Загружает артефакты

### 2. **security-check.yml** - Проверка безопасности
Запускается при каждом push:
- Анализирует код (flutter analyze)
- Проверяет форматирование
- Запускает linter
- Ищет hardcoded secrets
- Ищет print() вместо AppLogger

### 3. **deploy.yml** - Развертывание
Запускается при создании Release:
- Собирает iOS для TestFlight
- Собирает Android для Google Play
- Автоматически развертывает

---

## 📋 Шаг 1: Загрузить файлы на GitHub

### 1.1 Инициализируй Git репозиторий (если еще не сделал)
```bash
cd "Script Files"
git init
git add .
git commit -m "Initial commit"
```

### 1.2 Создай репозиторий на GitHub
1. Перейди на https://github.com/new
2. Назови репозиторий: `colibri-social-network`
3. Выбери "Private" (если хочешь приватный)
4. Нажми "Create repository"

### 1.3 Загрузи код на GitHub
```bash
git remote add origin https://github.com/YOUR_USERNAME/colibri-social-network.git
git branch -M main
git push -u origin main
```

---

## 🔧 Шаг 2: Настройка GitHub Actions

### 2.1 Проверь, что файлы на месте
Перейди в репозиторий → `.github/workflows/`

Должны быть:
- ✅ `flutter-build.yml`
- ✅ `security-check.yml`
- ✅ `deploy.yml`

### 2.2 Включи GitHub Actions
1. Перейди в репозиторий
2. Нажми вкладку "Actions"
3. Нажми "I understand my workflows, go ahead and enable them"

---

## 🧪 Шаг 3: Первый запуск

### 3.1 Сделай commit и push
```bash
git add .
git commit -m "Add GitHub Actions workflows"
git push
```

### 3.2 Смотри процесс сборки
1. Перейди в репозиторий → "Actions"
2. Выбери последний workflow
3. Смотри логи в реальном времени

### 3.3 Скачай собранное приложение
1. Когда сборка завершится, нажми на workflow
2. Внизу найди "Artifacts"
3. Скачай `app-release.apk` или `app-release.ipa`

---

## 📊 Мониторинг статуса

### Статус сборки в README
Добавь в начало README.md:

```markdown
# Colibri Social Network

![Flutter Build](https://github.com/YOUR_USERNAME/colibri-social-network/workflows/Flutter%20Build%20&%20Test/badge.svg)
![Security Check](https://github.com/YOUR_USERNAME/colibri-social-network/workflows/Security%20&%20Code%20Quality%20Check/badge.svg)

Социальная сеть на Flutter с Clean Architecture и BLoC.
```

---

## 🔐 Шаг 4: Настройка Secrets (для развертывания)

Если хочешь автоматически развертывать на TestFlight и Google Play:

### 4.1 Для Google Play
1. Перейди в репозиторий → Settings → Secrets and variables → Actions
2. Нажми "New repository secret"
3. Добавь:
   - **Name:** `PLAY_STORE_SERVICE_ACCOUNT`
   - **Value:** JSON ключ от Google Play Console

### 4.2 Для TestFlight (iOS)
1. Добавь secrets:
   - **APPSTORE_ISSUER_ID** - ID издателя App Store
   - **APPSTORE_API_KEY_ID** - ID API ключа
   - **APPSTORE_API_PRIVATE_KEY** - Приватный ключ

---

## 📈 Примеры использования

### Пример 1: Автоматическая сборка при push
```bash
# Ты делаешь изменения
git add .
git commit -m "Fix login bug"
git push

# GitHub Actions автоматически:
# 1. Загружает зависимости
# 2. Генерирует код
# 3. Запускает тесты
# 4. Собирает APK и IPA
# 5. Загружает артефакты
```

### Пример 2: Проверка безопасности
```bash
# Если ты случайно добавишь hardcoded пароль:
git add .
git commit -m "Add API key"
git push

# GitHub Actions найдет это и отклонит push:
# ⚠️ Found potential hardcoded secrets!
```

### Пример 3: Развертывание на TestFlight
```bash
# Создаешь Release на GitHub
# GitHub Actions автоматически:
# 1. Собирает iOS приложение
# 2. Загружает на TestFlight
# 3. Отправляет уведомление
```

---

## 🎯 Workflow статусы

### ✅ Успешно
```
✓ Setup Flutter
✓ Get dependencies
✓ Generate code
✓ Run tests
✓ Build APK
✓ Build IPA
✓ Upload artifacts
```

### ❌ Ошибка
Если что-то не работает, смотри логи:
1. Перейди в Actions
2. Выбери workflow
3. Нажми на шаг с ошибкой
4. Смотри логи

---

## 🐛 Решение проблем

### Проблема: "Flutter not found"
**Решение:** Убедись, что используешь `ubuntu-latest` для Linux сборок

### Проблема: "Build failed"
**Решение:** Смотри логи, обычно это проблемы с зависимостями
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Проблема: "Tests failed"
**Решение:** Запусти тесты локально
```bash
flutter test
```

### Проблема: "Artifacts not found"
**Решение:** Убедись, что сборка завершилась успешно

---

## 📚 Дополнительные возможности

### Добавить Slack уведомления
```yaml
- name: Notify Slack
  uses: slackapi/slack-github-action@v1
  with:
    webhook-url: ${{ secrets.SLACK_WEBHOOK }}
    payload: |
      {
        "text": "Build completed: ${{ job.status }}"
      }
```

### Добавить Email уведомления
```yaml
- name: Send email
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: Build ${{ job.status }}
    to: your-email@example.com
    body: Build completed successfully!
```

### Добавить автоматическое создание Release
```yaml
- name: Create Release
  uses: actions/create-release@v1
  with:
    tag_name: v${{ github.run_number }}
    release_name: Release ${{ github.run_number }}
    body: Automated release
```

---

## 🚀 Полный процесс разработки

```
1. Ты делаешь изменения в коде
   ↓
2. Коммитишь и пушишь на GitHub
   ↓
3. GitHub Actions автоматически:
   - Загружает зависимости
   - Генерирует код
   - Запускает тесты
   - Проверяет безопасность
   - Собирает APK и IPA
   ↓
4. Ты видишь результат в Actions
   ↓
5. Если все ✅, скачиваешь APK/IPA
   ↓
6. Тестируешь на устройстве
   ↓
7. Если готово, создаешь Release
   ↓
8. GitHub Actions автоматически развертывает на TestFlight/Google Play
```

---

## ✅ Чек-лист

- [ ] Репозиторий создан на GitHub
- [ ] Код загружен на GitHub
- [ ] GitHub Actions включены
- [ ] Файлы workflows на месте
- [ ] Первая сборка успешна
- [ ] APK/IPA скачаны
- [ ] Приложение протестировано
- [ ] Secrets добавлены (если нужно)

---

## 📞 Полезные ссылки

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter GitHub Actions](https://github.com/subosito/flutter-action)
- [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

---

**Версия:** 1.0
**Дата:** 2024
**Статус:** ✅ Готово

**Теперь ты можешь разрабатывать без локальной установки Flutter! 🎉**
