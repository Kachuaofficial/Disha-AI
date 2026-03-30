# Disha AI

Disha AI is a Flutter mobile app prototype focused on onboarding, authentication entry, and resume collection for a personalized AI career mentor experience.

## Overview

The app currently includes:

- A multi-step onboarding flow
- Authentication entry screen
- Resume upload screen using `file_picker`
- SVG asset rendering with `flutter_svg`
- Route management with `go_router`

This repository is in an early product stage, so some actions are still UI-first flows and do not yet connect to a backend service.

## Features

- Clean onboarding experience with swipeable intro screens
- Auth screen with multiple sign-in entry points
- Resume selection from phone storage
- Client-side file validation for `pdf`, `doc`, and `docx`
- Upload progress and success UI state
- Simple route-based navigation across screens

## Tech Stack

- Flutter
- Dart
- `go_router`
- `flutter_svg`
- `file_picker`

## Project Structure

```text
lib/
  main.dart
  resume_uploader.dart
  auth/
    auth_page.dart
  onboarding/
    onboarding_page.dart

assets/
  images/
```

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK included with Flutter
- Android Studio, VS Code, or another Flutter-compatible IDE
- A connected Android device, emulator, iPhone simulator, or desktop target

### Installation

1. Clone the repository.
2. Move into the project folder.
3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Current App Flow

1. The app opens on the onboarding screen.
2. The user moves through onboarding or skips ahead.
3. The auth screen acts as the entry point for sign-in.
4. The Google CTA currently routes to the resume upload screen.
5. The resume upload screen lets the user choose a file from phone storage and simulates upload success locally.

## Resume Upload Notes

The current resume feature uses `file_picker` to select files from the device.

Supported file types:

- PDF
- DOC
- DOCX

Current validation:

- Single file only
- Maximum file size: 5 MB

Current limitation:

- Upload is currently local UI behavior only
- No backend storage or API integration has been added yet

## Dependencies

Main packages used in `pubspec.yaml`:

- `go_router`
- `flutter_svg`
- `file_picker`
- `cupertino_icons`

## Development Notes

- Assets are loaded from `assets/images/`
- The app uses Material 3 theme configuration
- Navigation is configured centrally in `lib/main.dart`
- Some sign-in buttons still show placeholder snackbars

## Next Improvements

- Connect auth actions to a real authentication provider
- Upload resumes to cloud storage or an API
- Add a home/dashboard screen after onboarding and resume submission
- Persist onboarding completion state
- Add unit and widget tests

## Commands

Run the app:

```bash
flutter run
```

Analyze the project:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Status

This project is actively being shaped as a prototype. Expect fast iteration and some placeholder flows while the core user journey is being built.
