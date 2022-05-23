import 'package:flutter/material.dart';
import 'package:food_app/src/providers/main_provider.dart';
import 'package:food_app/src/view/screens/foods.dart';
import 'package:provider/provider.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

String? name;
String? content;

class _AddFoodState extends State<AddFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 105, 13),
          title: Text(
            'Add Food',
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
                    GestureDetector(
                      onTap: () {
                        provider.selectFile();
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey,
                        child: provider.file == null
                            ? Container()
                            : Image.file(
                                provider.file!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name of Food"),
                          TextFormField(
                            onChanged: ((value) {
                              name = value;
                            }),
                          ),
                          Text("Ingredients of Food"),
                          TextFormField(
                            onChanged: (value) {
                              content = value;
                              print(content);
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange)),
                          onPressed: () async {
                            await provider.addFood(name!, content!);

                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => foodScreen()),
                            );
                          },
                          child: Text("ADD")),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
