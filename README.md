# Buddy - Routine Tracker App

A beautiful and modern Flutter application for tracking daily routines, habits, and tasks. Built with a clean, intuitive design inspired by modern UI/UX principles.

## Features

### 🏠 Home Dashboard
- Daily progress overview with visual indicators
- Quick action buttons for common tasks
- Recent tasks display
- Habit progress tracking
- Personalized greetings based on time of day

### ✅ Task Management
- Create, edit, and delete tasks
- Priority levels (High, Medium, Low)
- Task categories (Work, Health, Personal, Learning)
- Task completion tracking
- Filter by status (All, Pending, Completed)

### 📅 Calendar View
- Monthly calendar with event indicators
- Add and manage events
- Color-coded event categories
- Date selection and navigation
- Event details and management

### 📈 Habit Tracking
- Track daily habits with progress indicators
- Streak counting and visualization
- Habit statistics and analytics
- Increment/decrement habit progress
- Multiple habit categories

### 👤 Profile & Settings
- User profile management
- Statistics dashboard
- Notification preferences
- Theme settings (Light/Dark mode)
- Language selection
- Data export and privacy settings

## Design Features

- **Modern UI**: Clean, minimalist design with smooth animations
- **Color Scheme**: Professional purple and blue gradient theme
- **Responsive**: Optimized for various screen sizes
- **Intuitive Navigation**: Bottom navigation bar with 5 main sections
- **Visual Feedback**: Progress bars, completion indicators, and status badges
- **Smooth Animations**: Transitions and micro-interactions for better UX

## Technical Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: StatefulWidget (built-in Flutter state management)
- **UI Components**: Material Design 3
- **Icons**: Material Icons
- **Platform Support**: Android, iOS, Web, Windows, macOS, Linux

## Getting Started

1. **Prerequisites**
   - Flutter SDK (3.0 or higher)
   - Dart SDK
   - Android Studio / VS Code
   - Device or emulator for testing

2. **Installation**
   ```bash
   git clone <repository-url>
   cd buddy
   flutter pub get
   ```

3. **Running the App**
   ```bash
   flutter run
   ```

4. **Building for Production**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   
   # Web
   flutter build web --release
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point and navigation
├── screens/
│   ├── home_screen.dart     # Dashboard and overview
│   ├── tasks_screen.dart    # Task management
│   ├── calendar_screen.dart # Calendar and events
│   ├── habits_screen.dart   # Habit tracking
│   └── profile_screen.dart  # User profile and settings
```

## Key Components

### Home Screen
- Progress overview cards
- Quick action buttons
- Recent tasks list
- Habit progress indicators

### Task Management
- Tabbed interface (All/Pending/Completed)
- Task creation and editing dialogs
- Priority and category management
- Completion tracking

### Calendar
- Monthly grid view
- Event management
- Color-coded categories
- Date selection

### Habits
- Progress tracking
- Streak visualization
- Statistics dashboard
- Habit management

### Profile
- User statistics
- Settings management
- Theme preferences
- Account management

## Customization

The app is designed to be easily customizable:

- **Colors**: Modify the color scheme in `main.dart`
- **Themes**: Update theme data for different visual styles
- **Icons**: Replace Material Icons with custom icons
- **Layouts**: Adjust spacing and sizing in individual screens
- **Features**: Add new functionality by extending existing screens

## Future Enhancements

- [ ] Data persistence with local storage
- [ ] Cloud synchronization
- [ ] Push notifications
- [ ] Widget customization
- [ ] Advanced analytics
- [ ] Social features
- [ ] Goal setting and tracking
- [ ] Export/import functionality

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Screenshots

The app features a modern, clean interface with:
- Gradient cards and smooth animations
- Intuitive navigation and user-friendly design
- Comprehensive task and habit management
- Beautiful calendar integration
- Detailed progress tracking and statistics

## Support

For support, questions, or feature requests, please open an issue in the repository.

---

Built with ❤️ using Flutter