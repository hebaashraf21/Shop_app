import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/FavoritesModel.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/styles/colors.dart';

import '../../shared/components/components.dart';
import '../Layout/cubit/cubit.dart';

class FavouritesScreen extends StatelessWidget
{
  @override
    Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            if (ShopCubit.get(context).favoritesModel!.data!.data!.isEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 150),
                child: Column(
                  children: const [
                    Center(
                        child: Icon(
                      Icons.favorite_border_outlined,
                      size: 200,
                      color: Colors.grey,
                    )),
                    Text("Your favorite is empty",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            Expanded(
              child: ConditionalBuilder(
                condition: state is! ShopHomeGetFavoritesLoadingState,
                builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildListProduct(
                      ShopCubit.get(context).favoritesModel!
                          .data!
                          .data![index]
                          .product!,
                      context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopCubit.get(context).favoritesModel!
                      .data!
                      .data!
                      .length,
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        );
      },
    );
  }
}