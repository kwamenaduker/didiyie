# Firebase Configuration Instructions

## To complete the Firebase setup:

### 1. Create a Firebase Project
- Go to [Firebase Console](https://console.firebase.google.com/)
- Create a new project named "Didi Yie"

### 2. Register Your Android App
- Package name: `com.example.didiyie` (or your custom package name)
- Download the `google-services.json` file
- Place it in the `/android/app/` directory

### 3. Register Your iOS App
- Bundle ID: Match your iOS app's bundle ID
- Download the `GoogleService-Info.plist` file
- Place it in your Xcode project (drag and drop in the Runner directory)
- Make sure to check "Copy items if needed"

### 4. Enable Authentication Methods
- In Firebase Console, go to Authentication → Sign-in methods
- Enable Email/Password authentication

### 5. Set Up Firestore
- Go to Firestore Database
- Create a new database in production mode
- Choose a location close to Ghana or your users
- Create a collection named "users" (this will be created automatically with your first user)

### 6. Security Rules
- Add appropriate security rules to your Firestore database
- Basic example rules are provided below:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 7. Test Your Setup
- After completing these steps, run the app and test the authentication flow
- Try signing up, logging in, and logging out
