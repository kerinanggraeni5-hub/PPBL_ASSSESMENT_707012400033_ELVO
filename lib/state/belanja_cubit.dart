import 'package:flutter_bloc/flutter_bloc.dart';

class BelanjaCubit extends Cubit<int> {
  BelanjaCubit() : super(0);

  void tambahBarang([int jumlah = 1]) {
    if (jumlah > 0) {
      emit(state + jumlah);
    }
  }

  void kurangiBarang() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}
