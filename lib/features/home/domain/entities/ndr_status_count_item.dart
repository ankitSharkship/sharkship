import 'package:equatable/equatable.dart';

class NdrStatusCountItem extends Equatable {
  final bool isNdr;
  final int count;

  const NdrStatusCountItem({required this.isNdr, required this.count});

  @override
  List<Object?> get props => [isNdr, count];
}
