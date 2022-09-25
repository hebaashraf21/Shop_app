import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/CategoriesModel.dart';
import 'package:shop/modules/Layout/cubit/cubit.dart';
import 'package:shop/modules/Layout/cubit/states.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: ((context, state) {
        var cubit=ShopCubit.get(context);
        
        return ListView.separated(
          itemBuilder:(context,index)=>CategoryItem(cubit.categoriesmodel!.data!.data[index]),
           separatorBuilder: (context,index)=>Container(height: 1,color: Color.fromARGB(255, 210, 209, 209),width: double.infinity,),
            itemCount: cubit.categoriesmodel!.data!.data.length);
      })
    );
    
    throw UnimplementedError();
  }


  Widget CategoryItem(DataModel model)
  {
    return Padding(padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Image(image: NetworkImage("${model.image}"),height: 100,width: 100,fit: BoxFit.cover,),
        SizedBox(width:20),
        Text("${model.name}",style: TextStyle(fontSize: 25),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)

      ],
    ),);
  }

}