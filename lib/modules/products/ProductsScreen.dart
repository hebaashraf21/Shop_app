import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/CategoriesModel.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/modules/Layout/cubit/cubit.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/styles/colors.dart';

class ProductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
    (
      listener: (context,state){
        if(state is ShopChangeFavoritesSuccessState)
        {
          if(state.model.status==false)
          {
            showToast(text: "${state.model.message}", state: ToastState.ERROR);

          }
        }
      },
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homemodel!=null &&cubit.categoriesmodel!=null,
           builder: (context)=>ProductsBuilder(cubit.homemodel,cubit.categoriesmodel,context),
            fallback:(context)=>Center(child: CircularProgressIndicator(),));
      },

    );
    throw UnimplementedError();
  }

  Widget ProductsBuilder(HomeModel? model, CategoriesModel? categorymodel,context)
  {
    return SingleChildScrollView(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

           SizedBox(height:10),


           Padding(padding: EdgeInsets.symmetric(horizontal: 15),
           child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",style: TextStyle(fontSize: 25),),

           SizedBox(height:10),

           Container(
            height: 120,
            child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder:(context,index)=> BuildCategoryItem(categorymodel.data!.data[index]),
             separatorBuilder: (context,index)=>SizedBox(width: 15),
              itemCount: categorymodel!.data!.data.length),
           ),

          
           
           SizedBox(height:20),

           Text("New Products",style: TextStyle(fontSize: 25),),

           SizedBox(height:20),
            ],
           ),
           ),


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
               (index) => ProductsGrid(model.data!.products[index],context)),
              ),
           )


      ],
    ),
    );
  }


  Widget BuildCategoryItem(DataModel model)
  {
    return  Stack(
            alignment: AlignmentDirectional.bottomEnd,
            
            children: [
              Image(image: NetworkImage("${model.image}",),height: 100,width: 100,fit: BoxFit.cover,),
              Container(
                width: 100,
                color: Colors.black.withOpacity(0.8),
                child:Text("${model.name}",style: TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis,),maxLines: 1,textAlign: TextAlign.center,)
                
              )

            ],
           );

  }

  Widget ProductsGrid(ProductModel model,context)
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
                     IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id!);
                        //print(model.id);
                        },
                       icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:(ShopCubit.get(context).favorites[model.id]==true)?defaultColor:Colors.grey,
                        child: Icon(Icons.favorite_border,color: Colors.white,size:14),
                       ))
                    ],
                  )
                    ],
                  ),)
                ],
               ),
    );
  }

}