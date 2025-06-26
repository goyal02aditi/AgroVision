# AgroVision - Agriculture Assistant App

## Overview

AgroVision is a Flutter-based mobile application designed to assist farmers with crop analysis, disease diagnosis, yield prediction, and agricultural guidance. The app provides a comprehensive suite of tools including image-based crop analysis, weather monitoring, soil health tracking, and an AI-powered chatbot for agricultural queries.

The application is built as a cross-platform mobile app targeting both Android and iOS, with web support enabled for development and testing purposes.

## System Architecture

### Frontend Architecture
- **Framework**: Flutter with Dart SDK 3.0+
- **Architecture Pattern**: Stateful widget-based architecture with clear separation of concerns
- **Navigation**: Bottom navigation bar with three main tabs (Home, Help, Profile)
- **State Management**: Built-in Flutter state management using StatefulWidget and setState
- **UI Theme**: Custom material design theme with agriculture-focused green color palette

### Key Components

#### Core Screens
- **HomeScreen**: Main dashboard with weather, navigation cards, and news feed
- **AnalyzeCropScreen**: Image capture/upload interface for crop analysis
- **ChatbotScreen**: AI assistant interface for agricultural queries
- **ProfileScreen**: User profile and settings management
- **HelpScreen**: Support and information resources

#### Specialized Analysis Screens
- **ChooseAnalysisScreen**: Selection between crop analysis and disease diagnosis
- **CropAnalysisResultsScreen**: Weather data, soil health charts, and yield comparisons
- **DiseaseDiagnosisScreen**: Disease identification and treatment recommendations
- **CropYieldPredictorScreen**: State and crop selection for yield predictions
- **YieldDetailsScreen**: Historical yield data and predictions with charts

#### Supporting Screens
- **CropHistoryScreen**: Historical analysis records
- **AboutUsScreen**: App information and company details
- **ReportIssueScreen**: Bug reporting and feedback form
- **TermsConditionsScreen**: Legal information and terms

#### Reusable Widgets
- **WeatherCard**: Displays current weather conditions
- **NavigationCard**: Home screen quick action cards
- **NewsCard**: News and tips display component
- **SoilHealthChart**: Data visualization for soil metrics
- **BottomNavigationWrapper**: Main navigation container

#### Data Models
- **Weather**: Weather data structure with temperature, humidity, and conditions
- **CropHistory**: Historical analysis records
- **NewsItem**: News and agricultural tips structure

## Data Flow

### Image Analysis Workflow
1. User captures/selects crop image via **AnalyzeCropScreen**
2. Image is passed to **ChooseAnalysisScreen** for analysis type selection
3. Based on selection, user is directed to either:
   - **CropAnalysisResultsScreen** for comprehensive crop analysis
   - **DiseaseDiagnosisScreen** for disease-specific diagnosis

### Yield Prediction Workflow
1. User selects Indian state from dropdown in **CropYieldPredictorScreen**
2. Available crops are filtered based on selected state using **Constants.cropsByState**
3. User selects specific crop and proceeds to **YieldDetailsScreen**
4. Historical yield data and predictions are displayed with charts

### Navigation Flow
- Bottom navigation provides access to Home, Help, and Profile sections
- Home screen serves as central hub with quick action cards
- Each feature maintains its own navigation stack for deep functionality

## External Dependencies

### Flutter Packages
- **image_picker (^1.0.4)**: Camera and gallery image selection
- **fl_chart (^0.64.0)**: Data visualization and charting
- **google_fonts (^6.1.0)**: Typography and font management
- **cupertino_icons (^1.0.2)**: iOS-style icons

### Development Dependencies
- **flutter_test**: Unit and widget testing framework
- **flutter_lints (^3.0.0)**: Code quality and style enforcement

### Assets
- **Images**: Stored in `assets/images/` directory
- **Icons**: Stored in `assets/icons/` directory

## Deployment Strategy

### Development Environment
- **Platform**: Replit with Flutter module support
- **Channel**: Stable Nix channel (24_05)
- **Development Server**: Flutter web server on port 5000
- **Hot Reload**: Enabled for rapid development iteration

### Build Configuration
- **Target Platforms**: Android, iOS, and Web
- **Minimum SDK**: Flutter 3.10.0+, Dart 3.0+
- **Build Commands**: 
  - `flutter pub get` for dependency management
  - `flutter run -d web-server` for web development

### Production Considerations
- Mobile app deployment through Google Play Store and Apple App Store
- Web deployment for browser-based access
- Offline functionality for core features
- Image processing and storage optimization

## Changelog

- June 26, 2025. Initial setup

## User Preferences

Preferred communication style: Simple, everyday language.