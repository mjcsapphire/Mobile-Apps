import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure with EquatableMixin {
  final String message;
  ServerFailure({this.message = 'Some unexpected server failure occured!'})
      : super([message]);

  @override
  List<Object?> get props => [message];
}
