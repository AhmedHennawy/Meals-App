import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import '../screens/tabs_screen.dart';
import '../screens/filter_screen.dart';
class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function function) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        onTap: function);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => TabsScreen()));
          }),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
