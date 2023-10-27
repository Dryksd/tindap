import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tindapp/model/model_class.dart';

StreamController<bool> controllerCard = StreamController.broadcast();

class TinderCard extends StatelessWidget {
  final User user;

  const TinderCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: StreamBuilder(
          stream: controllerCard.stream,
          initialData: false,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Flexible(
                    fit: snapshot.data == false ? FlexFit.tight : FlexFit.loose,
                    child: GestureDetector(
                      onVerticalDragEnd: (DragEndDetails details) {
                        controllerCard.add(false);
                      },
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        controllerCard.add(true);
                      },
                      onTap: () {
                        // Открыть диалог с фотографиями пользователя

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: const Text('Альбом пользователя'),
                              content: SizedBox(
                                width: 200,
                                height: 350,
                                child: GridView.builder(
                                  itemCount: user.photos.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Image.network(
                                          user.photos[index],
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Закрыть'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Image.network(user.photos.first),
                    ),
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(user.company),
                  snapshot.data == true
                      ? Column(
                          children: [
                            Text(user.catchPhrase),
                            Text(user.bs),
                            Text(user.catchPhrase),
                            Text(user.bs),
                            Text(user.catchPhrase),
                            Text(user.bs),
                            Text(user.catchPhrase),
                            Text(user.bs),
                            Text(user.catchPhrase),
                            Text(user.bs),
                          ],
                        )
                      : Container()
                  // Остальное текстовое описание
                ],
              );
            }
            return Container();
          }),
    );
  }
}
