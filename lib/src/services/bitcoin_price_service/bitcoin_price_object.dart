import 'package:intl/intl.dart';

class BitcoinPrice {
  final double price;
  final double changePercent;
  final double changeValue;
  final DateTime dateTime;

  BitcoinPrice({
    required this.price,
    required this.changePercent,
    required this.changeValue,
    required this.dateTime,
  });

  static BitcoinPrice empty() => BitcoinPrice(
        price: 0,
        changePercent: 0,
        changeValue: 0,
        dateTime: DateTime.now(),
      );

  String get formattedDate =>
      DateFormat('h:mm:ssa MM/dd/yyyy').format(dateTime.toLocal());

  @override
  String toString() =>
      'BitcoinPrice(price: $price, changePercent: $changePercent, changeValue: $changeValue, dateTime: $dateTime)';
}
