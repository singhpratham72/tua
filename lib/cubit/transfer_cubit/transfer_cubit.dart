import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/cubit/transfer_cubit/transfer_state.dart';
import 'package:tua/models/transfer_model.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(LoadedState(Transfer()));

  Future<void> updateTransfer(Transfer transfer) async {
    emit(LoadedState(transfer));
  }

  Transfer? get transfer => (state as LoadedState).transfer;
}
