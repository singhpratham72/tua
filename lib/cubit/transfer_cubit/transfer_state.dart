import 'package:tua/models/transfer_model.dart';

abstract class TransferState {}

class LoadedState extends TransferState {
  LoadedState(this.transfer);

  final Transfer transfer;
  Object get props => transfer;
}
