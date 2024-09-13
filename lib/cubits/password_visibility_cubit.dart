import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordObscureText extends Cubit<Map<String, bool>> {
  PasswordObscureText()
      : super({
          'password': true,
          'confirm_password': true,
        });

  void toggleVisibility(String field) {
    emit({...state, field: !state[field]!});
  }
}
