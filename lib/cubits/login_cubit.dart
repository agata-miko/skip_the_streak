import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<String> {
  LoginCubit() : super('');

  void updateLoginText(String text) => emit(text);

  void clearLoginText() => emit('');
}