
import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  final int currentPage;
  final int from;
  final int lastPage;

  final int perPage;
  final int to;
  final int total;

  const Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
  
    required this.perPage,
    required this.to,
    required this.total,
  });



  @override
  List<Object> get props =>
      [currentPage, from, lastPage,  perPage, to, total];
}