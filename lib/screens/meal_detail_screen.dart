import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'mealDetailScreen';
  final Function toggleFunction;
  final Function isMealFavorite;
  MealDetailScreen(this.toggleFunction, this.isMealFavorite);
  Widget sectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget sctionContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            sectionTitle(context, 'Ingredients'),
            sctionContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(meal.ingredients[index]),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            sectionTitle(context, 'Steps'),
            sctionContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${index + 1}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
                itemCount: meal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(isMealFavorite(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => toggleFunction(mealId)),
    );
  }
}
