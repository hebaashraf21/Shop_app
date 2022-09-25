import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Layout/HomeScreen.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/modules/onBoarding.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/bloc_observer.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/styles/themes.dart';

import 'modules/Layout/cubit/cubit.dart';
import 'modules/Layout/cubit/states.dart';

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
  CacheHelper.SaveData(key: 'token', value: 'jnefurbrhfecdb');
  
   token=CacheHelper.GetData(key: 'token');
   print(token);
  print(OnBoarding);

 late Widget widget;

  if(onBoarding!=null)
  {
    if(token!=null)
    {
      widget=HomeScreen();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> ShopCubit()..GetHomeData()

        ),
      ],
          child: BlocConsumer<ShopCubit,ShopStates>(
          listener:(context,state){},
          builder: (context,state) {
          //AppCubit cubit = AppCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: LightTheme,
              home: HomeScreen()
              //theme: lightMode(),
              //darkTheme: darkMode(),
              //themeMode: cubit.appMode,
              );
  }
  )
    );
  }
}

