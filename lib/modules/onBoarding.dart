import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingModel {
  String image;
  String title;
  String body;

  onBoardingModel(
      {required this.image, required this.title, required this.body});
}

class onBoardingScreen extends StatefulWidget {
  @override
  onBoarding createState() {
    return onBoarding();
    throw UnimplementedError();
  }
}

class onBoarding extends State<onBoardingScreen> {
  bool isLast = false;
  var pageController = PageController();

  List<onBoardingModel> onBoardingList = [
    onBoardingModel(
        image: "assets/images/onboarding1.jpg",
        title: "1",
        body: "111111111111111111111"),
    onBoardingModel(
        image: "assets/images/onboarding2.jpg",
        title: "2",
        body: "222222222222222222222"),
    onBoardingModel(
        image: "assets/images/onboarding3.png",
        title: "3",
        body: "333333333333333333333"),
  ];

  void submit()
  {
    CacheHelper.SaveData(key: 'OnBoarding', value: true).then((value) 
    {
      if(value)
      {
        navigateAndFinish(context, LoginScreen());
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text("SKIP"))
        ]),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      itemCount: onBoardingList.length,
                      onPageChanged: (index) {
                        if (index == onBoardingList.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      controller: pageController,
                      itemBuilder: (context, index) =>
                          pageItem(onBoardingList[index])),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: 3,
                        effect: WormEffect(), // your preferred effect
                        onDotClicked: (index) {}),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        }
                      },
                    ),
                  ],
                ),
              ],
            )));
    throw UnimplementedError();
  }

  Widget pageItem(onBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(image: AssetImage('${model.image}')),
        ),
       // SizedBox(height: 10),
        Text(
          "${model.title}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "${model.body}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
