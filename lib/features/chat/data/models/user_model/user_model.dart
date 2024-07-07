import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'user_model.g.dart';

///[UserModel] is a class that extends [Equatable] which is a class that helps to compare objects of the same type.
///[UserModel] is a class that is used to store the user details.
///[name] is a variable of type [String] which is used to store the name of the user.
///[id] is a variable of type [String] which is used to store the id of the user.
///
@HiveType(typeId: 2)
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
