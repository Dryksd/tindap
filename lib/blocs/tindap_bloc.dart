import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tindapp/blocs/tindap_event.dart';
import 'package:tindapp/blocs/tindap_state.dart';
import 'package:tindapp/model/model_class.dart';

StreamController<List> controller = StreamController();

class UsersBloc extends Bloc<UsersEvent, AuthState> {
  late Timer timeron;
  int curIndex = 0;
  List curUsersList = [];

  UsersBloc() : super(UsersState(users: const [], currentIndex: 0)) {
    on<LoadUsers>((event, emit) async {
      List users = [];

      final usersResponse = await fetchUsers();

      usersResponse.forEach((number) {
        users.add(User.fromJson(number));
      });

      for (User number in users) {
        final photoResponse = await fetchPhotos(number.id);
        photoResponse.forEach((val) {
          number.photos.add(val['url']);
        });
      }

      timeron = Timer.periodic(const Duration(seconds: 1), (timer) {
        controller.add(users);
      });

      curUsersList = users;
      emit(UsersState(users: users, currentIndex: 0));
    });

    on<PlusOneUsers>((event, emit) {
      timeron.cancel();

      if (curIndex < 9) {
        curIndex += 1;
        int curIndexValue = curIndex;
        emit(UsersState(users: curUsersList, currentIndex: curIndexValue));
      } else {
        curIndex = 0;

        int curIndexValue = curIndex;
        emit(UsersState(users: curUsersList, currentIndex: curIndexValue));
      }
    });

    on<MinusOneUsers>((event, emit) {
      timeron.cancel();

      if (curIndex > 0) {
        curIndex -= 1;
        int curIndexValue = curIndex;
        emit(UsersState(users: curUsersList, currentIndex: curIndexValue));
      } else {
        curIndex = 9;

        int curIndexValue = curIndex;
        emit(UsersState(users: curUsersList, currentIndex: curIndexValue));
      }
    });
  }
}

Future fetchUsers() async {
  const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  final response = await http.get(Uri.parse(baseUrl));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load");
  }
}

Future fetchPhotos(int numberId) async {
  String baseUrl =
      'https://jsonplaceholder.typicode.com/albums/$numberId/photos';

  final response = await http.get(Uri.parse(baseUrl));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load");
  }
}
