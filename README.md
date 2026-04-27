# Project 10: Flutter Layered Architecture

This app loads real users data from an Open API and shows:
- Users list screen
- Company statistics screen (new feature)

## API
- Source: `https://dummyjson.com/users?limit=20`
- Authentication: no API key required

## Run
1. Install Flutter SDK.
2. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Project Structure
```text
lib/
  main.dart
  features/users/
    presentation/
      bloc/
      screens/
    domain/
      entities/
      repositories/
      usecases/
    data/
      datasources/
      models/
      repositories/
```

## Layer Responsibilities
- `presentation`: UI widgets and user interactions (`StreamBuilder`, screens, BLoC state output)
- `domain`: business rules and entities (`GetUsersUseCase`, `GetCompanyStatsUseCase`)
- `data`: API calls and mapping DTO -> domain entity

## Where Main Business Logic Is
- Load users: [lib/features/users/domain/usecases/get_users_use_case.dart](lib/features/users/domain/usecases/get_users_use_case.dart)
- New feature logic (company aggregation): [lib/features/users/domain/usecases/get_company_stats_use_case.dart](lib/features/users/domain/usecases/get_company_stats_use_case.dart)
