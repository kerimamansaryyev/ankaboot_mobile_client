import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageTabBloc extends Cubit<int> {
  HomePageTabBloc() : super(0);

  void setIndex(int index) => emit(index);
}
