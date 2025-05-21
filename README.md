# Didi Yie - AI Ghanaian Food Recognition App

<p align="center">
  <img src="assets/images/logo.png" alt="Didi Yie Logo" width="200"/>
</p>

## 📱 Overview

Didi Yie is an AI-powered mobile application designed to recognize traditional Ghanaian foods, provide detailed nutritional information, and offer cultural context. The app is built with Flutter and employs a custom-trained YOLOv8 object detection model for accurate food recognition, even without an internet connection.

## ✨ Key Features

- **Real-time Food Recognition**: Identify traditional Ghanaian dishes using the device camera
- **Comprehensive Nutritional Analysis**: Get detailed nutritional breakdowns for local foods
- **Cultural Context**: Learn about the history and significance of traditional dishes
- **Offline Functionality**: Full operation without internet connectivity
- **Packaged Food Recognition**: Scan barcodes to identify packaged products
- **User Preferences**: Save favorite foods and dietary restrictions
- **Intuitive UI**: Culturally relevant design with Ghanaian-inspired elements

## 🛠️ Technology Stack

- **Frontend**: Flutter/Dart for cross-platform mobile development
- **AI Model**: Custom-trained YOLOv8 object detection model
- **ML Framework**: TensorFlow Lite for on-device inference
- **Database**: Local SQLite for food data storage
- **External API**: Open Food Facts for packaged food information
- **State Management**: GetX for reactive state management

## 🚀 Installation

```bash
# Clone the repository
git clone https://github.com/kwamenaduker/didiyie.git

# Navigate to the project directory
cd didiyie

# Install dependencies
flutter pub get

# Run the app in debug mode
flutter run
```

## 📊 Project Structure

```
lib/
├── didiyie_controllers/  # Business logic and controllers
│   └── food_controller.dart  # YOLOv8 implementation
├── didiyie_models/      # Data models
│   └── food_model.dart  # Food data structure
├── didiyie_page/        # UI screens
│   ├── didiyie_homepage/  # Main app screens
│   └── didiyie_Authentication/  # Auth screens
├── didiyie_theme/       # Theming
├── tools/               # Utility functions
└── main.dart            # App entry point
```

## 🔍 How It Works

1. **Image Capture**: The app captures an image of food using the device camera
2. **AI Processing**: The YOLOv8 model processes the image to identify the food
3. **Data Retrieval**: Nutritional information is fetched from the local database
4. **Result Display**: The app presents comprehensive information about the food

## 🌟 Screenshots

<p align="center">
  <img src="assets/screenshots/scan_screen.png" width="200" />
  <img src="assets/screenshots/results_screen.png" width="200" /> 
  <img src="assets/screenshots/nutrition_screen.png" width="200" />
</p>

## 🔮 Future Developments

- Expanded food database with more regional Ghanaian dishes
- Personalized health recommendations based on scan history
- Social features for sharing discoveries and recipes
- Integration with fitness tracking applications

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Contributors

- Kwamena Duker - Project Lead & Developer

## 🙏 Acknowledgments

- Thanks to the Ghana Culinary Research Institute for food data
- Ultralytics for the YOLOv8 model framework
- Open Food Facts for their comprehensive API
