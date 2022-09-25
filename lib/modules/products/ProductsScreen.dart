import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/modules/Layout/cubit/cubit.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/styles/colors.dart';

class ProductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
    (
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homemodel!=null,
           builder: (context)=>ProductsBuilder(cubit.homemodel),
            fallback:(context)=>Center(child: CircularProgressIndicator(),));
      },

    );
    throw UnimplementedError();
  }

  Widget ProductsBuilder(HomeModel? model)
  {
    return SingleChildScrollView(
      
      child: Column(
      children: [
        CarouselSlider(
          items: model!.data!.banners.map((e) => Image(image: NetworkImage('${e.image}'),width: double.infinity,fit: BoxFit.cover,)).toList() ,
           options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1

           )),

           SizedBox(height:20),

           Container(
            color: Colors.grey[300],
            child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.58,
              children: List.generate(model.data!.products.length,
               (index) => ProductsGrid(model.data!.products[index])),
              ),
           )


      ],
    ),
    );
  }

  Widget ProductsGrid(ProductModel model)
  {
    return Container(
      color: Colors.white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200,
                 ),
                 if(model.discount!=0)
                 Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                 child: Container(
                  color: Colors.red,
                  child: Text("DISCOUNT",style: TextStyle(fontSize: 12,color: Colors.white),),
                 ),)
                    ],
                  ),
                  SizedBox(height: 5,),

                  Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${model.name}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(height: 1.3),),
                      SizedBox(height:5),

                  Row(
                    children: [
                      Text("${model.price.round()}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(height: 1.3,color: defaultColor),),
                      SizedBox(width: 5,),
                     if(model.discount!=0)
                       Text("${model.old_price.round()}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(height: 1.3,color: Colors.grey,fontSize: 12,decoration: TextDecoration.lineThrough),),
                     Spacer(),
                     IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border),padding: EdgeInsets.zero,)
                    ],
                  )
                    ],
                  ),)
                ],
               ),
    );
  }

}