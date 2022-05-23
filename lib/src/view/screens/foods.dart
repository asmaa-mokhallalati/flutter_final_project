import 'package:flutter/material.dart';
import 'package:food_app/src/providers/main_provider.dart';
import 'package:food_app/src/view/screens/add_food.dart';
import 'package:food_app/src/view/screens/food-detials.dart';

import 'package:provider/provider.dart';

class foodScreen extends StatefulWidget {
  @override
  State<foodScreen> createState() => _foodScreenState();
}

class _foodScreenState extends State<foodScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 241, 105, 13),
            title: Text(
              'All Foods',
              style: TextStyle(color: Colors.white),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFood()),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Color.fromARGB(255, 241, 105, 13),
          ),
          body: Consumer<mainProviders>(
            builder: (context, provider, x) {
              if (provider.foods == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: provider.foods.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(provider.foods[index].id),
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete),
                          alignment: Alignment.centerRight,
                        ),
                        onDismissed: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            // Left to right
                            print("Edit");
                          }
                          setState(() async {
                            await provider.deleteFood(provider.foods[index].id);

                            provider.foods
                                .remove(provider.foods.removeAt(index));
                          });
                        },
                        child: InkWell(
                          onTap: () async {
                            await provider.getfood(provider.foods[index].id);
                            Future.delayed(Duration(seconds: 2));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => foodDetials()),
                            );
                          },
                          child: Container(
                            height: 150,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    provider.foods[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.7),
                                              Colors.transparent
                                            ])),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            provider.foods[index].name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          )),
    );
  }
}
