import 'package:flutter/material.dart';
import 'package:food_app/src/view/screens/food-detials.dart';
import 'package:provider/provider.dart';

import '../../providers/main_provider.dart';

class edit_food extends StatefulWidget {
  const edit_food({Key? key}) : super(key: key);

  @override
  State<edit_food> createState() => _edit_foodState();
}

String name = "food";
String content = "food";

class _edit_foodState extends State<edit_food> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 105, 13),
          title: Text(
            'Edit Food',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<mainProviders>(
          builder: (context, provider, x) {
            if (provider.food == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
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
                          TextFormField(
                            onChanged: ((value) {
                              name = value;
                              print(name);
                            }),
                            initialValue: provider.food.name,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              content = value;
                              print(content);
                            },
                            initialValue: provider.food.content,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange)),
                          onPressed: () {
                            provider.editFood(provider.food.id, name, content);

                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => foodDetials()),
                            );
                          },
                          child: Text("Edit")),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
