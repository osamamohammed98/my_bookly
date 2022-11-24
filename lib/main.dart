import 'package:bloc_basic/cubit/weather_cubit.dart';
import 'package:bloc_basic/firebase_options.dart';
import 'package:bloc_basic/pages/home_page.dart';
import 'package:bloc_basic/services/weather_service.dart';
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
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(WeatherService()),
      child: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: WeatherCubit.instance(context).weatherModel == null
                  ? Colors.blue
                  : WeatherCubit.instance(context)
                      .weatherModel
                      ?.getThemeColor(),
            ),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
