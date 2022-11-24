import 'package:bloc_basic/cubit/counter_cubit.dart';
import 'package:bloc_basic/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PointsCounter());
}


class PointsCounter extends StatelessWidget {
  const PointsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CounterCubit.instance(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: const Text('Points Counter'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Team E',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            Text(
                              '${cubit.teamAPoints}',
                              style: const TextStyle(
                                fontSize: 150,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                primary: Colors.orange,
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () => cubit.addOnTeamEPoints(cubit.teamAPoints += 1),
                              child: const Text(
                                'Add 1 Point ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () => cubit.addOnTeamEPoints(cubit.teamAPoints += 2),
                              child: const Text(
                                'Add 2 Point',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () => cubit.addOnTeamEPoints(cubit.teamAPoints += 3),
                              child: const Text(
                                'Add 3 Point ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 500,
                        child: VerticalDivider(
                          indent: 50,
                          endIndent: 50,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Team B',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            Text(
                              '${cubit.teamBPoints}',
                              style: const TextStyle(
                                fontSize: 150,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                primary: Colors.orange,
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () => cubit.addOnTeamBPoints(cubit.teamBPoints += 1),
                              child: const Text(
                                'Add 1 Point ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () => cubit.addOnTeamBPoints(cubit.teamBPoints += 2),
                              child: const Text(
                                'Add 2 Point ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                minimumSize: const Size(150, 50),
                              ),
                              onPressed: () => cubit.addOnTeamBPoints(cubit.teamBPoints += 3),
                              child: const Text(
                                'Add 3 Point ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      primary: Colors.orange,
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () => cubit.resetPoints(),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
