import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Login/cubit/states.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  void UserLogin({
    required String email,
    required String password
  })
  {
    emit(ShoploginLoadingState());
    DioHelper.postdata(
      url: LOGIN,
      data: {
        'email':email,
        'password':password
      }).then((value) {
        print(value.data);
        emit(ShopLoginSuccessState());
      }).catchError((onError){
        emit(ShopLoginErrorState(onError.toString()));
      });
  }


}