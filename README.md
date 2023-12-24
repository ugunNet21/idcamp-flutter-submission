## First Image:
![App Screenshot](https://github.com/ugunNet21/idcamp-flutter-middleup/assets/45864165/442141ac-17c9-416d-a3be-e510b36c3353)

## Updated Images:
1. **Home Dashboard**
   ![Home Dashboard](https://github.com/ugunNet21/idcamp-flutter-submission/assets/45864165/6d222675-cefe-4b2c-b0b8-e5911e3903a1)
   - **Description**: This screenshot illustrates the Home Dashboard of the application.

2. **Detail Restaurant**
   ![Detail Restaurant](https://github.com/ugunNet21/idcamp-flutter-submission/assets/45864165/a5ec5c82-13b2-4ae9-aa4b-3b96ac2faa47)
   - **Description**: This screenshot showcases the detailed view of a specific restaurant.

3. **Detail Restaurant Rating**
   ![Detail Restaurant Rating](https://github.com/ugunNet21/idcamp-flutter-submission/assets/45864165/4801171c-0173-40eb-b6bd-f0cbc6559313)
   - **Description**: This screenshot highlights the restaurant details along with user ratings.

4. **Add Review**
   ![Add Review](https://github.com/ugunNet21/idcamp-flutter-submission/assets/45864165/b9c96e3b-7b55-43e4-976a-19d824972921)
   - **Description**: This screenshot exhibits the user interface for adding a review to a restaurant.

# Restaurant Finder App

## Overview

This Flutter project helps users find and explore information about various restaurants in a specific area. The application utilizes the [Restaurant API Dicoding](https://restaurant-api.dicoding.dev/) to fetch restaurant data.

## Libraries

The application uses several Flutter libraries and packages:

- `http`: Used for making HTTP requests to the restaurant API.
- `carousel_slider`: Enables the use of a carousel to display advertisements or promotions.
- `flutter_rating_bar`: Provides a widget for displaying ratings in a star format.
- `provider`: Used for state management in the application.

## Concepts and Features

1. **GetX Library**: The application incorporates the GetX library for state management, navigation, and dependency injection.

2. **Home Dashboard**: The main page displays a list of restaurants with several sections, including user profile, search button, ad carousel, and restaurant list.

3. **Restaurant Detail Page**: A page that provides detailed information about a specific restaurant, including description, location, menu, and customer reviews.

4. **Search Functionality**: Users can search for restaurants based on name or specific keywords.

5. **Add Review Feature**: Users can add reviews or comments for a particular restaurant.

6. **Navigation System**: The app uses a navigation system with `MaterialPageRoute` and `Navigator` to switch between pages.

7. **Pull-to-Refresh**: Implementation using `RefreshIndicator` allows users to pull down the screen to refresh restaurant data.

## Project Structure

- `lib/models`: Contains data model definitions such as `Restaurant`, `RestaurantDetail`, `Category`, `MenuList`, `MenuItem`, and `CustomerReview`.

- `lib/services`: Holds business logic related to data requests from the API, like `RestaurantService`.

- `lib/ui`: Contains user-visible pages, such as `HomeDashboardPage`, `RestaurantDetailPage`, and `RestaurantSearchPage`.

- `lib/ui/widgets`: Includes small reusable widgets, like `HomeCarousel` and others.

## Running the Application

1. Ensure the Flutter SDK is installed on your machine.
2. Clone this repository.
3. Open a terminal in the project directory and run `flutter pub get` to download all dependencies.
4. Run the application with the command `flutter run`.

## Notes

- Replace placeholder data, such as image URLs or API endpoints, with actual data in the code.
- Check and adjust internet access permissions in the `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist` files.

**Happy coding!**
