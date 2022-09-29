import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Layout/HomeScreen.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/modules/Splash/SplashScreen.dart';
import 'package:shop/modules/onBoarding.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/bloc_observer.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/styles/themes.dart';

import 'modules/Layout/cubit/cubit.dart';
import 'modules/Layout/cubit/states.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.GetData(key: 'isDark');
  bool? OnBoarding=CacheHelper.GetData(key: 'OnBoarding');  
   token=CacheHelper.GetData(key: 'token');
   
   print(token);
  print(OnBoarding);



  runApp(MyApp(
    isDark: isDark,));
}

class MyApp extends StatelessWidget {

  final bool? isDark;

  MyApp({
     this.isDark,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> ShopCubit()..GetHomeData()..GetCategoriesData()..getUserData()

        ),
      ],
          child: BlocConsumer<ShopCubit,ShopStates>(
          listener:(context,state){},
          builder: (context,state) {
          //AppCubit cubit = AppCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: LightTheme,
              home: SplashScreen()
              //theme: lightMode(),
              //darkTheme: darkMode(),
              //themeMode: cubit.appMode,
              );
  }
  )
    );
  }
}

