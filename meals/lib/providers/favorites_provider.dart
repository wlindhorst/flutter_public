import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  void toggleMealFavoriteStatus(Meal meal) {
    // state holds a list of meals (provided by riverpod framework)
    final mealIsFavorite = state.contains(meal);

    // to remove a meal from fav
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      // .. spread operator - keep current meals in state - and add the current meal
      state = [...state, meal];
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
