import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/categories.dart';
import 'screens/meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filter_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _favoriteMeals = [];
  List<Meal> _avaliableMeals = DUMMY_MEALS;
  void _selectFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _avaliableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId){
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
          fontFamily: 'Relaway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      home: TabsScreen(_favoriteMeals),
      routes: {
        MealsScreen.routeName: (context) => MealsScreen(_avaliableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(_selectFilters, _filters),
      },
    );
  }
}
