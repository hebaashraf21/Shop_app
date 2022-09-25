import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Layout/ShopHome.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/modules/onBoarding.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/bloc_observer.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.GetData(key: 'isDark');
  bool? OnBoarding=CacheHelper.GetData(key: 'OnBoarding');
  var token=CacheHelper.GetData(key: 'token');
  print(OnBoarding);

 late Widget widget;

  if(onBoarding!=null)
  {
    if(token!=null)
    {
      widget=ShopHome();
    }
    else
    {
      widget=LoginScreen();
    }

  }
  else
  {
    widget=onBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget:widget,));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget? startWidget;

  MyApp({
     this.isDark,
     this.startWidget
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ShopHome(),
    );
  }
}

