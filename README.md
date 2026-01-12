# Conversion App - Flutter

## Overview

This is a simple **Unit Conversion App** built using **Flutter** and **Dart**.  
The app allows users to:

- Enter a numeric value
- Select a unit to convert **from**
- Select a unit to convert **to**
- Displays the conversion result

## Getting Started

### Prerequisites

- Flutter SDK installed: [Flutter Installation](https://flutter.dev/docs/get-started/install)  
- Android Studio or emulator setup  
- A physical device or Android emulator running

### Installation

1. Clone the repository:
```bash
git clone git@github.com:Kejmerkew/MSCS-533-A01_ConversionApp.git
```

2. Navigate to the project folder:
```bash
cd conversion_app
```

3. Fetch dependencies:
```bash
flutter pub get
```

4. Run the app on a connected device or emulator:
```bash
flutter run -d emulator-5554
```

### Note
- Only compatible unit types can be converted (length → length, weight → weight, volume → volume)
- Invalid conversions display an error message!
