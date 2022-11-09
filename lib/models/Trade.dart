import 'Toy.dart';

class Trade {
  List<Toy> senderToys;
  List<Toy> recieverToys;
  String tradeStatus;

  Trade(
      this.senderToys,
      this.recieverToys,
      this.tradeStatus
      );
}