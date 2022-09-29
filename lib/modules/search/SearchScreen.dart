import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Layout/cubit/cubit.dart';
import 'package:shop/modules/Layout/cubit/states.dart';
import 'package:shop/modules/search/cubit/cubit.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/styles/colors.dart';

import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context , state) {},
        builder: (context , state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        label: Text('Search'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search)
                      ),
                      keyboardType: TextInputType.text,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return 'Search must not be empty';
                        }
                        return null;
                      },
                      onFieldSubmitted:(String? text){
                        SearchCubit.get(context).search(text: text);
                      } ,
                    ),
                    const SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).searchModel!.data!.data![index], context,isOldPrice: false),
                        separatorBuilder: (context, index) => Container(
                          height: .4,
                          width: double.infinity,
                          color: defaultColor,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                        ),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}