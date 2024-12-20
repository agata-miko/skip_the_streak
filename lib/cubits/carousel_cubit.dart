import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselCubit extends Cubit<String?> {
  CarouselCubit() : super(null);

  void selectImage(String imagePath) {
    emit(imagePath);
  }
}