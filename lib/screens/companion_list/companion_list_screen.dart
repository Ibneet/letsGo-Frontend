import 'package:flutter/material.dart';
import './companion_list.dart';

class CompanionListScreen extends StatelessWidget {
  static const routeName = '/companion-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
      padding: EdgeInsets.only(top: 20),
      itemBuilder: (ctx, index) {
        return CompanionList();
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    ));
  }
}
