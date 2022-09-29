import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/styles/colors.dart';
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
        image: "assets/images/on1.jpg",
        title: "Salla",
        body: "Your favorite market in your pocket"),
    onBoardingModel(
        image: "assets/images/on2.jpg",
        title: "Categories",
        body: "You will find all your needs"),
    onBoardingModel(
        image: "assets/images/on3.jpg",
        title: "Discounts",
        body: "Up to 50%"),
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
              child: Text("SKIP",style: TextStyle(color: defaultColor),))
        ]),
        body: Padding(
          
            padding: EdgeInsets.only(right:10,left: 10,bottom: 70,top: 0),
            child: Container(
              color: Colors.white,
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
                        effect: SlideEffect(activeDotColor: defaultColor,), // your preferred effect
                        onDotClicked: (index) {}),
                    Spacer(),
                    
                  ],
                ),
              ],
            ),
            )),

            floatingActionButton:FloatingActionButton(
                      
                      
                      
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios_outlined),
                      backgroundColor:defaultColor,
                      
                    ),
            );
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
