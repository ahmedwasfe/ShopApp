import 'package:bmi_calculator/models/shop/boarding_model.dart';
import 'package:bmi_calculator/modules/shop/login/shop_login_screen.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  var pagerController = PageController();
  bool isLast = false;

  List<Boarding> listBoarding = [
    Boarding(
        image: 'assets/images/boarding1.jpeg',
        title: 'Board Title One',
        body: 'Board Body One'),
    Boarding(
        image: 'assets/images/boarding2.jpg',
        title: 'Board Title Two',
        body: 'Board Body Tow'),
    Boarding(
        image: 'assets/images/boarding3.jpg',
        title: 'Board Title Three',
        body: 'Board Body Three'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
          child: Text("SKIP"),
              onPressed: () => goToLoginScreen()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pagerController,
                itemBuilder: (context, index) => buildBoarding(listBoarding[index]),
                itemCount: listBoarding.length,
                onPageChanged: (index) {
                  if(index == listBoarding.length - 1)
                    setState(() => isLast = true);
                  else
                    setState(() => isLast = false);
                  print("Last Index $index");
                },
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pagerController,
                  count: listBoarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: deepDefaultColor,
                    // dotHeight: 10.0,
                    // dotWidth: 10.0,
                    // expansionFactor: 4.0,
                    // spacing: 5.0,
                  ),
                  onDotClicked: (index) {
                    pagerController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInToLinear);
                  },
                ),
                Spacer(),
                FloatingActionButton(
                    child: Icon(Icons.arrow_forward),
                    mini: false,
                    onPressed: (){
                      if(isLast)
                        goToLoginScreen();
                      else
                        pagerController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeInToLinear);
                    }),
              ],
            ),
          ],
        ),
      ),

    );
  }

  void goToLoginScreen(){
    CacheHelper.saveData(key: Const.KEY_BOARDING, value: true)
    .then((value) {
      if(value)
        navigateAndFinish(context, ShopLoginScreen());
    });
  }
}
