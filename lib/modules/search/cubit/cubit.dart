import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/SearchModel.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit
{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;

  void Search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text':text},token: token).then(
      (value) {
        searchModel=SearchModel.fromJson(value.data);
        emit(SearchSuccessState());
      }).catchError((err)
      {
        emit(SearchErrorState());

      });

  }

}