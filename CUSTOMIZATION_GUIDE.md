# 🎨 Гайд по кастомизации Colibri

## 📋 Содержание
1. [Переименование приложения](#переименование-приложения)
2. [Изменение цветов и стилей](#изменение-цветов-и-стилей)
3. [Изменение логотипа и иконок](#изменение-логотипа-и-иконок)
4. [Изменение API](#изменение-api)
5. [Добавление новых функций](#добавление-новых-функций)
6. [Добавление языков](#добавление-языков)

---

## 🏷️ Переименование приложения

### Шаг 1: Изменить название в pubspec.yaml
```yaml
# Script Files/pubspec.yaml

name: colibri_social_network  # Измени на свое имя
description: A new Flutter project.
publish_to: 'none'

version: 1.0.0+1
```

### Шаг 2: Изменить название на Android
```gradle
# Script Files/android/app/build.gradle

android {
  ...
  defaultConfig {
    applicationId "com.example.myapp"  # Измени на свой ID
    minSdkVersion 24
    targetSdkVersion 33
    versionCode 1
    versionName "1.0.0"
  }
}
```

### Шаг 3: Изменить название на iOS
```swift
# Script Files/ios/Runner/Info.plist

<key>CFBundleName</key>
<string>MyApp</string>  <!-- Измени на свое имя -->

<key>CFBundleDisplayName</key>
<string>My App</string>  <!-- Измени на свое имя -->
```

### Шаг 4: Переименовать папку проекта (опционально)
```bash
cd "Script Files"
mv . ../my-app
cd ../my-app
```

---

## 🎨 Изменение цветов и стилей

### Шаг 1: Открыть файл цветов
```dart
// Script Files/lib/core/theme/colors.dart

class AppColors {
  // Основные цвета
  static const Color primary = Color(0xFF6200EE);      // Фиолетовый
  static const Color secondary = Color(0xFF03DAC6);    // Бирюзовый
  static const Color tertiary = Color(0xFFFF0000);     // Красный
  
  // Нейтральные цвета
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  
  // Цвета для состояний
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
}
```

### Шаг 2: Изменить цвета
```dart
// Пример: Изменить основной цвет на синий
static const Color primary = Color(0xFF2196F3);  // Синий вместо фиолетового
```

### Шаг 3: Применить цвета в теме
```dart
// Script Files/lib/core/theme/app_theme.dart

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,  // Используется основной цвет
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  );
}
```

### Шаг 4: Изменить шрифты
```dart
// Script Files/lib/core/theme/text_styles.dart

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: 'Campton',  // Измени на свой шрифт
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'CeraPro',  // Измени на свой шрифт
  );
}
```

---

## 🖼️ Изменение логотипа и иконок

### Шаг 1: Подготовить изображения

Нужны изображения в разных размерах:
- **Android**: 192x192, 512x512 px
- **iOS**: 1024x1024 px
- **Web**: 512x512 px

### Шаг 2: Заменить иконку приложения на Android
```bash
# Скопируй изображения в папку
cp icon_192.png "Script Files/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png"
cp icon_512.png "Script Files/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher_foreground.png"
```

### Шаг 3: Заменить иконку приложения на iOS
```bash
# Скопируй изображение в папку
cp icon_1024.png "Script Files/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png"
```

### Шаг 4: Использовать flutter_launcher_icons (рекомендуется)
```yaml
# Script Files/pubspec.yaml

dev_dependencies:
  flutter_launcher_icons: ^0.13.0

flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon.png"
  image_path_ios: "assets/icon/icon_ios.png"
```

Запусти:
```bash
flutter pub run flutter_launcher_icons
```

### Шаг 5: Заменить логотип в приложении
```dart
// Script Files/lib/features/authentication/presentation/pages/login_screen.dart

Image.asset(
  'assets/images/logo.png',  // Измени путь на свой логотип
  width: 200,
  height: 200,
)
```

---

## 🔌 Изменение API

### Шаг 1: Создать .env файл
```bash
# Script Files/.env

API_BASE_URL=https://your-api.com/api
API_TIMEOUT=30
LOG_LEVEL=INFO
```

### Шаг 2: Обновить AppConfig
```dart
// Script Files/lib/core/config/app_config.dart

class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://www.colibri-sm.ru/mobile_api/',
  );
  
  static const int apiTimeout = int.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: 30,
  );
}
```

### Шаг 3: Обновить API endpoints
```dart
// Script Files/lib/core/common/api/api_constants.dart

class ApiConstants {
  static const String baseUrl = 'https://your-api.com/api';
  
  // Endpoints
  static const String loginEndPoint = '/auth/login';
  static const String signUpEndPoint = '/auth/signup';
  static const String getFeedEndPoint = '/feed';
  static const String createPostEndPoint = '/posts/create';
  static const String getProfileEndPoint = '/users/{userId}';
}
```

### Шаг 4: Обновить модели данных
```dart
// Script Files/lib/features/feed/data/models/post_model.dart

class PostModel {
  final String id;
  final String userId;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final DateTime createdAt;
  
  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });
  
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      imageUrl: json['image_url'],
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
```

---

## ➕ Добавление новых функций

### Пример: Добавить функцию "Поиск пользователей"

#### Шаг 1: Создать структуру папок
```
lib/features/search/
├── data/
│   ├── datasources/
│   │   └── search_remote_datasource.dart
│   ├── models/
│   │   └── user_search_model.dart
│   └── repositories/
│       └── search_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user_search_entity.dart
│   ├── repositories/
│   │   └── search_repository.dart
│   └── usecases/
│       └── search_users_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── search_cubit.dart
    │   └── search_state.dart
    ├── pages/
    │   └── search_screen.dart
    └── widgets/
        └── search_result_card.dart
```

#### Шаг 2: Создать Entity
```dart
// lib/features/search/domain/entities/user_search_entity.dart

class UserSearchEntity {
  final String id;
  final String name;
  final String avatarUrl;
  final String bio;
  final bool isFollowing;
  
  UserSearchEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required this.isFollowing,
  });
}
```

#### Шаг 3: Создать Repository Interface
```dart
// lib/features/search/domain/repositories/search_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/common/failure.dart';
import '../entities/user_search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<UserSearchEntity>>> searchUsers(String query);
}
```

#### Шаг 4: Создать UseCase
```dart
// lib/features/search/domain/usecases/search_users_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../../core/common/failure.dart';
import '../entities/user_search_entity.dart';
import '../repositories/search_repository.dart';

class SearchUsersUseCase {
  final SearchRepository repository;
  
  SearchUsersUseCase(this.repository);
  
  Future<Either<Failure, List<UserSearchEntity>>> call(String query) async {
    return await repository.searchUsers(query);
  }
}
```

#### Шаг 5: Создать Cubit
```dart
// lib/features/search/presentation/bloc/search_cubit.dart

import 'package:bloc/bloc.dart';
import '../../domain/entities/user_search_entity.dart';
import '../../domain/usecases/search_users_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUsersUseCase searchUsersUseCase;
  
  SearchCubit(this.searchUsersUseCase) : super(SearchInitial());
  
  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    
    emit(SearchLoading());
    final result = await searchUsersUseCase(query);
    result.fold(
      (failure) => emit(SearchFailure(failure.message)),
      (users) => emit(SearchLoaded(users)),
    );
  }
}
```

#### Шаг 6: Создать UI
```dart
// lib/features/search/presentation/pages/search_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Users')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                context.read<SearchCubit>().searchUsers(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Center(child: Text('Start searching'));
                } else if (state is SearchLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.bio),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Подписаться на пользователя
                          },
                          child: Text(user.isFollowing ? 'Following' : 'Follow'),
                        ),
                      );
                    },
                  );
                } else if (state is SearchFailure) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🌍 Добавление языков

### Шаг 1: Добавить JSON файл перевода
```json
// Script Files/assets/translations/es.json (Испанский)

{
  "app_name": "Colibrí",
  "login": "Iniciar sesión",
  "signup": "Registrarse",
  "email": "Correo electrónico",
  "password": "Contraseña",
  "home": "Inicio",
  "profile": "Perfil",
  "messages": "Mensajes",
  "settings": "Configuración"
}
```

### Шаг 2: Обновить pubspec.yaml
```yaml
# Script Files/pubspec.yaml

flutter:
  assets:
    - assets/translations/en.json
    - assets/translations/es.json
    - assets/translations/fr.json
    - assets/translations/de.json
```

### Шаг 3: Использовать переводы в коде
```dart
// lib/core/localization/app_localizations.dart

import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  Future<bool> load() async {
    String jsonString = await rootBundle.loadString(
      'assets/translations/${locale.languageCode}.json',
    );
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.cast<String, String>();
    return true;
  }
  
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
```

### Шаг 4: Использовать в UI
```dart
// lib/features/authentication/presentation/pages/login_screen.dart

Text(AppLocalizations.of(context).translate('login'))
```

---

## 📦 Публикация приложения

### На Google Play
1. Создай аккаунт Google Play Developer
2. Подготовь скриншоты и описание
3. Собери release APK/AAB
4. Загрузи на Google Play Console
5. Заполни информацию о приложении
6. Отправь на модерацию

### На App Store
1. Создай аккаунт Apple Developer
2. Подготовь скриншоты и описание
3. Собери release IPA
4. Загрузи на App Store Connect
5. Заполни информацию о приложении
6. Отправь на модерацию

---

## ✅ Чек-лист кастомизации

- [ ] Переименовано приложение
- [ ] Изменены цвета и стили
- [ ] Заменены логотип и иконки
- [ ] Обновлены API endpoints
- [ ] Добавлены новые функции
- [ ] Добавлены переводы
- [ ] Протестировано на разных устройствах
- [ ] Готово к публикации

---

**Версия:** 1.0
**Дата:** 2024
**Статус:** ✅ Готово
