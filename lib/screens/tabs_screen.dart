import 'package:flutter/material.dart';
import '../screens/categories.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';
class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen([this.favoriteMeals]);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages ; 
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
    {'title': 'Categories', 'page': Categories()},
    {'title': 'Favorites', 'page': FavoritesScreen(widget.favoriteMeals)},
  ];
    super.initState();
  }
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer() ,
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
              backgroundColor: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
