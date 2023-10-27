import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthState extends Equatable {
  late final List users;

  late final int currentIndex;
}

class UsersState extends AuthState {
  UsersState({required this.users, required this.currentIndex});

  @override
  final List users;
  @override
  final int currentIndex;

  @override
  List<Object> get props => [users, currentIndex];
}