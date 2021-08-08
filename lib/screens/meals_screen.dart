import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = 'mealsScreen';
  final List<Meal> availableMeal;
  MealsScreen(this.availableMeal);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String title;
  List<Meal> meals;
  var _initialData = false;

  @override
  void didChangeDependencies() {
    if (!_initialData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final String catId = routeArgs['id'];
      title = routeArgs['title'];
      meals =
          widget.availableMeal.where((meal) => meal.categories.contains(catId)).toList();
      _initialData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(mealId) {
    setState(() {
      meals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: meals[index].id,
              title: meals[index].title,
              imageUrl: meals[index].imageUrl,
              duration: meals[index].duration,
              complexity: meals[index].complexity,
              affordability: meals[index].affordability,
            );
          },
          itemCount: meals.length,
        ));
  }
}
