import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'user_model.g.dart'; // This file will be generated by Hive

@HiveType(typeId: 2) // Ensure the typeId is unique if you have other HiveTypes
class UserModel extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  const UserModel({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
