# 🏗️ Архитектура Colibri - Clean Architecture + BLoC

## 📚 Содержание
1. [Общая архитектура](#общая-архитектура)
2. [Слои приложения](#слои-приложения)
3. [Поток данных](#поток-данных)
4. [Компоненты](#компоненты)
5. [Примеры](#примеры)

---

## 🎯 Общая архитектура

Приложение использует **Clean Architecture** с **BLoC** для управления состоянием:

```
┌─────────────────────────────────────────────────────────┐
│                  PRESENTATION LAYER                     │
│  (UI Widgets, BLoC/Cubit, State Management)             │
│                                                         │
│  Отвечает за: Отображение UI, обработка пользовательского ввода │
└────────────────────┬────────────────────────────────────┘
                     │ Зависит от
┌────────────────────▼────────────────────────────────────┐
│                   DOMAIN LAYER                          │
│  (Entities, Repositories, UseCases)                     │
│                                                         │
│  Отвечает за: Бизнес логика, независимая от фреймворка │
└────────────────────┬────────────────────────────────────┘
                     │ Зависит от
┌────────────────────▼────────────────────────────────────┐
│                    DATA LAYER                           │
│  (Models, DataSources, Repository Implementations)      │
│                                                         │
│  Отвечает за: Получение данных (API, БД, SharedPrefs)  │
└────────────────────┬────────────────────────────────────┘
                     │ Зависит от
┌────────────────────▼────────────────────────────────────┐
│                    CORE LAYER                           │
│  (Utils, Config, DI, Constants)                         │
│                                                         │
│  Отвечает за: Общие утилиты, конфигурация, инъекция    │
└─────────────────────────────────────────────────────────┘
```

---

## 📊 Слои приложения

### 1️⃣ PRESENTATION LAYER (UI + State Management)

**Папка:** `lib/features/*/presentation/`

**Компоненты:**
- **Pages** - Полные экраны приложения
- **Widgets** - Переиспользуемые компоненты UI
- **BLoC/Cubit** - Управление состоянием

**Пример структуры:**
```
features/authentication/presentation/
├── pages/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── forgot_password_screen.dart
├── widgets/
│   ├── email_input_field.dart
│   ├── password_input_field.dart
│   └── login_button.dart
└── bloc/
    ├── auth_cubit.dart
    └── auth_state.dart
```

**Ответственность:**
- Отображение UI
- Обработка пользовательского ввода
- Отправка событий в BLoC
- Слушание изменений состояния
- Навигация между экранами

**Правила:**
- ❌ Не содержит бизнес логику
- ❌ Не обращается напрямую к API
- ❌ Не содержит сложную логику
- ✅ Только UI и управление состоянием

---

### 2️⃣ DOMAIN LAYER (Бизнес логика)

**Папка:** `lib/features/*/domain/`

**Компоненты:**
- **Entities** - Объекты бизнес логики (независимые от фреймворка)
- **Repositories** - Интерфейсы для получения данных
- **UseCases** - Бизнес логика (одна функция = одна бизнес операция)

**Пример структуры:**
```
features/authentication/domain/
├── entities/
│   ├── user_entity.dart
│   └── auth_entity.dart
├── repositories/
│   └── auth_repository.dart
└── usecases/
    ├── login_usecase.dart
    ├── signup_usecase.dart
    └── logout_usecase.dart
```

**Ответственность:**
- Определение бизнес правил
- Определение интерфейсов для данных
- Реализация бизнес логики в UseCases

**Правила:**
- ❌ Не зависит от Flutter
- ❌ Не зависит от конкретных реализаций
- ✅ Зависит только от абстракций (интерфейсов)
- ✅ Может быть переиспользовано в других проектах

---

### 3️⃣ DATA LAYER (Получение данных)

**Папка:** `lib/features/*/data/`

**Компоненты:**
- **Models** - Объекты для сериализации/десериализации JSON
- **DataSources** - Интерфейсы для получения данных (API, БД)
- **Repositories** - Реализация интерфейсов из Domain Layer

**Пример структуры:**
```
features/authentication/data/
├── models/
│   ├── login_request_model.dart
│   ├── login_response_model.dart
│   └── user_model.dart
├── datasources/
│   ├── auth_remote_datasource.dart
│   └── auth_local_datasource.dart
└── repositories/
    └── auth_repository_impl.dart
```

**Ответственность:**
- Получение данных из API
- Получение данных из локального хранилища
- Кэширование данных
- Преобразование Models в Entities

**Правила:**
- ✅ Зависит от Domain Layer
- ✅ Содержит конкретные реализации (Dio, SharedPreferences)
- ❌ Не содержит UI логику

---

### 4️⃣ CORE LAYER (Общие утилиты)

**Папка:** `lib/core/`

**Компоненты:**
- **Config** - Конфигурация приложения
- **API** - HTTP клиент (Dio)
- **Logger** - Логирование
- **SecureStorage** - Зашифрованное хранилище
- **DI** - Dependency Injection (GetIt)
- **Routes** - Навигация (AutoRoute)
- **Theme** - Темы и стили
- **Constants** - Константы приложения

**Пример структуры:**
```
core/
├── config/
│   └── app_config.dart
├── common/
│   ├── api/
│   │   ├── api_helper.dart
│   │   └── api_constants.dart
│   ├── logger/
│   │   └── app_logger.dart
│   ├── secure_storage/
│   │   └── secure_storage_service.dart
│   └── validators/
│       └── password_validator.dart
├── di/
│   └── injection.dart
├── routes/
│   └── routes.gr.dart
└── theme/
    ├── colors.dart
    ├── text_styles.dart
    └── app_theme.dart
```

**Ответственность:**
- Предоставление общих сервисов
- Конфигурация приложения
- Управление зависимостями

---

## 🔄 Поток данных

### Пример: Вход пользователя

```
1. USER INTERACTION
   └─ Пользователь вводит email и пароль
      └─ Нажимает кнопку "Sign In"

2. PRESENTATION LAYER
   └─ LoginScreen отправляет событие в AuthCubit
      └─ AuthCubit.login(email, password)

3. DOMAIN LAYER
   └─ AuthCubit вызывает LoginUseCase
      └─ LoginUseCase.call(email, password)

4. DATA LAYER
   └─ LoginUseCase вызывает AuthRepository
      └─ AuthRepository.login(email, password)
         └─ AuthRepositoryImpl отправляет HTTP запрос
            └─ ApiHelper.post('/login', {email, password})

5. CORE LAYER
   └─ ApiHelper отправляет запрос через Dio
      └─ Dio.post('https://api.colibri.com/login')

6. API SERVER
   └─ Сервер проверяет учетные данные
      └─ Возвращает токен и данные пользователя

7. DATA LAYER (обратно)
   └─ AuthRepositoryImpl получает ответ
      └─ Преобразует LoginResponseModel в UserEntity
      └─ Сохраняет токен в SecureStorage
      └─ Возвращает Either<Failure, UserEntity>

8. DOMAIN LAYER (обратно)
   └─ LoginUseCase получает результат
      └─ Возвращает Either<Failure, UserEntity>

9. PRESENTATION LAYER (обратно)
   └─ AuthCubit получает результат
      └─ Если успех: emit(Authenticated(user))
      └─ Если ошибка: emit(AuthenticationFailure(error))

10. UI UPDATE
    └─ LoginScreen слушает состояние AuthCubit
       └─ Если Authenticated: перенаправляет на FeedScreen
       └─ Если AuthenticationFailure: показывает ошибку
```

### Диаграмма потока:

```
┌──────────────────┐
│  LoginScreen     │
│  (UI Widget)     │
└────────┬─────────┘
         │ Пользователь нажимает кнопку
         ▼
┌──────────────────┐
│  AuthCubit       │
│  (State Manager) │
└────────┬─────────┘
         │ Вызывает UseCase
         ▼
┌──────────────────┐
│  LoginUseCase    │
│  (Business Logic)│
└────────┬─────────┘
         │ Вызывает Repository
         ▼
┌──────────────────┐
│  AuthRepository  │
│  (Interface)     │
└────────┬─────────┘
         │ Реализация
         ▼
┌──────────────────┐
│ AuthRepositoryImpl│
│  (Data Layer)    │
└────────┬─────────┘
         │ Отправляет запрос
         ▼
┌──────────────────┐
│  ApiHelper       │
│  (HTTP Client)   │
└────────┬─────────┘
         │ Использует Dio
         ▼
┌──────────────────┐
│  API Server      │
│  (Backend)       │
└────────┬─────────┘
         │ Возвращает ответ
         ▼
┌──────────────────┐
│  AuthRepositoryImpl
│  (Сохраняет токен)
└────────┬─────────┘
         │ Возвращает результат
         ▼
┌──────────────────┐
│  AuthCubit       │
│  (Обновляет      │
│   состояние)     │
└────────┬─────────┘
         │ Уведомляет UI
         ▼
┌──────────────────┐
│  LoginScreen     │
│  (Перенаправляет │
│   на FeedScreen) │
└──────────────────┘
```

---

## 🧩 Компоненты

### BLoC vs Cubit

**Cubit** (используется в этом проекте):
- Проще (нет событий)
- Меньше кода
- Подходит для простых операций

```dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginUseCase) : super(AuthInitial());

  final LoginUseCase loginUseCase;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(email, password));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }
}
```

**BLoC** (для сложных операций):
- Более мощный
- Больше кода
- Подходит для сложных операций с несколькими событиями

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
  }

  final LoginUseCase loginUseCase;

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(event.email, event.password));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }
}
```

### Either (для обработки ошибок)

Используется библиотека `dartz` для функционального программирования:

```dart
// Either<Left, Right>
// Left = Ошибка (Failure)
// Right = Успех (Data)

Either<Failure, UserEntity> result = await loginUseCase(...);

result.fold(
  (failure) {
    // Обработка ошибки
    print('Error: ${failure.message}');
  },
  (user) {
    // Обработка успеха
    print('User: ${user.name}');
  },
);
```

---

## 💡 Примеры

### Пример 1: Создание нового UseCase

```dart
// domain/usecases/get_user_profile_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import '../../../../core/common/failure.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String userId) async {
    return await repository.getUserProfile(userId);
  }
}
```

### Пример 2: Создание нового Cubit

```dart
// presentation/bloc/user_profile_cubit.dart

import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/entities/user_entity.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  UserProfileCubit(this.getUserProfileUseCase) : super(UserProfileInitial());

  Future<void> getUserProfile(String userId) async {
    emit(UserProfileLoading());
    final result = await getUserProfileUseCase(userId);
    result.fold(
      (failure) => emit(UserProfileFailure(failure.message)),
      (user) => emit(UserProfileLoaded(user)),
    );
  }
}
```

### Пример 3: Использование в UI

```dart
// presentation/pages/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_profile_cubit.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем профиль при открытии экрана
    context.read<UserProfileCubit>().getUserProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(state.user.avatarUrl),
                  radius: 50,
                ),
                SizedBox(height: 16),
                Text(state.user.name, style: TextStyle(fontSize: 20)),
                Text(state.user.bio),
              ],
            );
          } else if (state is UserProfileFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
```

---

## 🔐 Безопасность в архитектуре

### Как защищены данные:

1. **Токены** - Хранятся в SecureStorage (зашифрованы)
2. **API запросы** - Идут по HTTPS с TLS 1.2+
3. **Логирование** - Не содержит чувствительных данных
4. **Валидация** - На всех уровнях (UI, Domain, API)

### Слои безопасности:

```
┌─────────────────────────────────────┐
│  PRESENTATION LAYER                 │
│  ✅ Валидация пользовательского ввода│
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│  DOMAIN LAYER                       │
│  ✅ Бизнес правила безопасности     │
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│  DATA LAYER                         │
│  ✅ Валидация данных перед отправкой│
│  ✅ Сохранение токенов безопасно    │
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│  CORE LAYER                         │
│  ✅ HTTPS + TLS 1.2+                │
│  ✅ Зашифрованное хранилище         │
│  ✅ Безопасное логирование          │
└─────────────────────────────────────┘
```

---

## 📚 Дополнительные ресурсы

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Dartz Either](https://pub.dev/packages/dartz)
- [GetIt DI](https://pub.dev/packages/get_it)

---

**Версия:** 1.0
**Дата:** 2024
**Статус:** ✅ Готово
