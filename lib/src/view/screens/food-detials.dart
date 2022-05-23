import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/src/providers/main_provider.dart';
import 'package:food_app/src/view/screens/edit_food.dart';
import 'package:provider/provider.dart';

class foodDetials extends StatefulWidget {
  const foodDetials({Key? key}) : super(key: key);

  @override
  State<foodDetials> createState() => _foodDetialsState();
}

String? id;

class _foodDetialsState extends State<foodDetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 105, 13),
          title: Text(
            'Food Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => edit_food()),
            );
          },
          child: Icon(
            Icons.edit,
            color: Colors.black,
          ),
          backgroundColor: Color.fromARGB(255, 241, 105, 13),
        ),
        body: Consumer<mainProviders>(
          builder: (context, provider, x) {
            if (provider.food == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              id = provider.food.id;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    provider.food.image,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.food.name,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Ingredients :",
                          style: TextStyle(
                              fontSize: 32,
                              color: Color.fromARGB(255, 241, 105, 13),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          provider.food.content,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
