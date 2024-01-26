import 'package:isar/isar.dart';
part 'quote_db_entity.g.dart';

@collection
class QuoteDBEntity {
  final Id quoteId = Isar.autoIncrement;
  final String author;
  final String quote;
  final DateTime createdAt;
  final String languageCode;

  QuoteDBEntity({required this.author, required this.quote, required this.createdAt, required this.languageCode});
}
