import 'package:bloc_basic/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  SearchPage({this.updateUi});

  VoidCallback? updateUi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;

              await WeatherCubit.instance(context)
                  .getWeather(cityName: cityName!);

              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: Text('search'),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    await WeatherCubit.instance(context)
                        .getWeather(cityName: cityName!);

                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.search)),
              border: const OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }
}
