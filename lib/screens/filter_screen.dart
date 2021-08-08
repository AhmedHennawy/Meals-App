import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filters';
  final Function saveFilters;
  final Map<String,bool> currentFilters;
  FilterScreen(this.saveFilters,this.currentFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegatarine = false;
  var _vegan = false;
  var _lactoseFree = false;
  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegatarine = widget.currentFilters['vegetarian'];
    super.initState();
  }
  Widget _buildSwitch(
      String title, String subTitle, var currentVal, Function updateVal) {
    return SwitchListTile(
        value: currentVal,
        title: Text(title),
        subtitle: Text(subTitle),
        onChanged: updateVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selctedFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegatarine
                };
                widget.saveFilters(selctedFilter);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitch(
                  'Gluten-free', 'Only include gluten_free meals.', _glutenFree,
                  (newVal) {
                setState(() {
                  _glutenFree = newVal;
                });
              }),
              _buildSwitch('Lactose-free', 'Only include lactose_free meals.',
                  _lactoseFree, (newVal) {
                setState(() {
                  _lactoseFree = newVal;
                });
              }),
              _buildSwitch(
                  'Vegatarian', 'Only include vegetarian meals.', _vegatarine,
                  (newVal) {
                setState(() {
                  _vegatarine = newVal;
                });
              }),
              _buildSwitch('Vegan', 'Only include vegan meals.', _vegan,
                  (newVal) {
                setState(() {
                  _vegan = newVal;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
