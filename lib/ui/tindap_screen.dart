import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tindapp/blocs/tindap_bloc.dart';
import 'package:tindapp/blocs/tindap_event.dart';
import 'package:tindapp/blocs/tindap_state.dart';
import 'package:tindapp/ui/tindap_card.dart';

class TinderScreen extends StatelessWidget {
  const TinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, AuthState>(
        builder: (context, state) {
          return state.currentIndex == 0 && state.users.isEmpty
              ? StreamBuilder(
                  stream: controller.stream,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var user = snapshot.data[state.currentIndex];

                      return Column(
                        children: [
                          Expanded(
                            child: TinderCard(user: user),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  // Перейти к предыдущей карточке
                                  context
                                      .read<UsersBloc>()
                                      .add(MinusOneUsers());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  // Перейти к следующей карточке

                                  context.read<UsersBloc>().add(PlusOneUsers());
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })
              : Column(
                  children: [
                    Expanded(
                      child: TinderCard(user: state.users[state.currentIndex]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            // Перейти к предыдущей карточке
                            context.read<UsersBloc>().add(MinusOneUsers());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            // Перейти к следующей карточке

                            context.read<UsersBloc>().add(PlusOneUsers());
                          },
                        ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
