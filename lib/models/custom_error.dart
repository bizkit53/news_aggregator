import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs
class CustomError extends Equatable implements Exception {
  const CustomError({
    this.code = '',
    this.message = '',
    this.plugin = '',
  });

  final String code;
  final String message;
  final String plugin;

  @override
  List<Object> get props => [code, message, plugin];

  @override
  bool get stringify => true;
}
