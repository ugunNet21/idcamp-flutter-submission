# flutter_subm_1

![image](https://github.com/ugunNet21/idcamp-flutter-middleup/assets/45864165/442141ac-17c9-416d-a3be-e510b36c3353)

# Restaurant Finder App

## Overview

This Flutter project is designed to help users find and explore information about various restaurants in a specific area. The application utilizes the [Restaurant API Dicoding](https://restaurant-api.dicoding.dev/) to fetch restaurant data.

## Libraries

The application makes use of several Flutter libraries and packages, including:

- `http`: Used for making HTTP requests to the restaurant API.
- `carousel_slider`: Enables the use of a carousel to display advertisements or promotions.
- `flutter_rating_bar`: Provides a widget for displaying ratings in star format.
- `provider`: Used for state management in the application.

## Concepts and Features

1. **Home Dashboard**: The main page displays a list of restaurants with several sections, including user profile, search button, ad carousel, and restaurant list.

2. **Restaurant Detail Page**: A page that provides detailed information about a specific restaurant, including description, location, menu, and customer reviews.

3. **Search Functionality**: Users can search for restaurants based on name or specific keywords.

4. **Add Review Feature**: Users can add reviews or comments for a particular restaurant.

5. **Navigation System**: The app uses a navigation system with `MaterialPageRoute` and `Navigator` to switch between pages.

6. **Pull-to-Refresh**: Implementation using `RefreshIndicator` allows users to pull down the screen to refresh restaurant data.

## Project Structure

- `lib/models`: Contains data model definitions such as `Restaurant`, `RestaurantDetail`, `Category`, `MenuList`, `MenuItem`, and `CustomerReview`.

- `lib/services`: Holds business logic related to data requests from the API, like `RestaurantService`.

- `lib/ui`: Contains user-visible pages, such as `HomeDashboardPage`, `RestaurantDetailPage`, and `RestaurantSearchPage`.

- `lib/ui/widgets`: Includes small reusable widgets, like `HomeCarousel` and others.

## Running the Application

1. Make sure the Flutter SDK is installed on your machine.
2. Clone this repository.
3. Open a terminal in the project directory and run `flutter pub get` to download all dependencies.
4. Run the application with the command `flutter run`.

## Notes

Ensure to replace some placeholders with actual data in the code, such as image URLs or API endpoints that might change. Also, check and adjust internet access permissions in the `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist` files.

**Happy coding!**
