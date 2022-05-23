import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/src/Auth/create_account.dart';
import 'package:food_app/src/view/screens/foods.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const AdsScreenBody();
}

class AdsScreenBody extends StatefulWidget {
  const AdsScreenBody({Key? key}) : super(key: key);

  @override
  _AdsScreenBodyState createState() => _AdsScreenBodyState();
}

class _AdsScreenBodyState extends State<AdsScreenBody> {
  List<Ads> adsList = [
    Ads(
        image: 'chinese_noodles.svg',
        description: 'All the new recipes you find here ',
        title: 'New recipes'),
    Ads(
        image: 'burger_beer.svg',
        description: 'You can add and save your own recipes in the app',
        title: 'Add your recipes'),
    Ads(
        image: 'chinese_noodles.svg',
        description: 'You can edit your recipes any time you want',
        title: 'Edit your own recipes'),
  ];

  @override
  void initState() {
    super.initState();

    buttonCarouselController = CarouselController();
  }

  int _current = 0;
  CarouselController? buttonCarouselController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Expanded(
            child: CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  height: double.infinity,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: adsList
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/${e.image}',
                              height: MediaQuery.of(context).size.height * 0.4,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                e.title!,
                                style: const TextStyle(
                                  fontSize: 31,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                e.description!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),

              // AppShared.adsResponse.ads.length,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: adsList.asMap().entries.map((entry) {
                          return GestureDetector(
                            child: Container(
                              width: 30.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(5),
                                  // border: Border.all(
                                  //     color: Theme.of(context).primaryColor
                                  // ),
                                  color: _current == entry.key
                                      ? Color.fromARGB(255, 241, 105, 13)
                                      : Color.fromARGB(255, 247, 174, 125)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    child: _current == adsList.length - 1
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccount()),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 241, 105, 13),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.done,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                _current++;
                              });
                              buttonCarouselController!.nextPage();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 241, 105, 13),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            )),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class Ads {
  String? image;
  String? title;
  String? description;
  Ads({this.image, this.title, this.description});
}
