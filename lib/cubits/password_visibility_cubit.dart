import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordObscureText extends Cubit<bool> {

  PasswordObscureText() : super(true);

  void toggleVisibility() => emit(!state);
}