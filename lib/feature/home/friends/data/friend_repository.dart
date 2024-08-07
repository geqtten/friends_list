import 'package:friends_list/feature/home/friends/data/friend_data_source.dart';
import 'package:friends_list/feature/home/friends/model/friend_entity.dart';

abstract class FriendRepository {
  Future<FriendEntity> createFriend({
    required String name,
    required String lastName,
  });
  Future<List<FriendEntity>> getFriendsByName(String name);

  Future<int> deleteFriend(int id);

  Future<int> updateFriend({
    required String name,
    required String lastName,
    required int id,
  });

  Future<List<FriendEntity>> getAllFriends();
}

class FriendRepositoryImpl implements FriendRepository {
  FriendRepositoryImpl(FriendDataSource dataSource) : _dataSource = dataSource;

  final FriendDataSource _dataSource;

  @override
  Future<FriendEntity> createFriend({
    required String name,
    required String lastName,
  }) async {
    final newFriend = await _dataSource.createFriend(
      name: name,
      lastName: lastName,
    );

    return FriendEntity.fromModel(newFriend);
  }

  @override
  Future<List<FriendEntity>> getAllFriends() async {
    final allFriends = await _dataSource.getAllFriends();
    if (allFriends.isNotEmpty) {
      return allFriends
          .map(
            (dto) => FriendEntity.fromModel(dto),
          )
          .toList();
    }
    return [];
  }

  @override
  Future<int> deleteFriend(int id) async {
    final deleteFriend = await _dataSource.deleteFriend(id);
    return deleteFriend;
  }

  @override
  Future<int> updateFriend({
    required int id,
    required String name,
    required String lastName,
  }) async =>
      await _dataSource.updateFriend(
        id: id,
        name: name,
        lastName: lastName,
      );

  @override
  Future<List<FriendEntity>> getFriendsByName(String name) async {
    final result = await _dataSource.getFriendsByName(name);

    if (result.isNotEmpty) {
      return result
          .map(
            (dto) => FriendEntity.fromModel(dto),
          )
          .toList();
    }
    return [];
  }
}
