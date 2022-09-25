import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class ShopHome extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salla"),
      ),
      body: TextButton(
        child: Text("Sign out"),
        onPressed: (){
          CacheHelper.RemoveData(key: 'token').then((value) {
            if(value)
            {
              navigateAndFinish(context, LoginScreen());
            }
          });
        },
      ),
    );
    throw UnimplementedError();
  }

}