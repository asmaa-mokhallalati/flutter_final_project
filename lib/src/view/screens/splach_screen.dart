import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/src/providers/main_provider.dart';
import 'package:food_app/src/view/screens/ads_screen.dart';

import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 6)).then((value) {
      Provider.of<mainProviders>(context, listen: false).getAllFood();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdsScreen()),
      );
    });

    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/burger_beer.svg',
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Food App",
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 105, 13),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
