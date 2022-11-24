import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bloc_basic/cubit/weather_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_basic/models/weather_model.dart';
import 'package:bloc_basic/pages/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      // listener: (context, state) {
      //   // TODO: implement listener
      // },
      builder: (context, state) {
        var cubit = WeatherCubit.instance(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage(
                      updateUi: (){},
                    );
                  }));
                },
                icon: const Icon(Icons.search),
              ),
            ],
            title: const Text('Weather App'),
          ),
          body: AnimatedConditionalBuilder(
            condition: state is WeatherLoadingState,
            builder: (BuildContext context) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
            fallback: (BuildContext context) {
              return AnimatedConditionalBuilder(
                condition: state is WeatherErrorState ||
                    WeatherCubit.instance(context).weatherModel == null,
                builder: (BuildContext context) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'there is no weather 😔 start',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'searching now 🔍',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        cubit.weatherModel!.getThemeColor(),
                        cubit.weatherModel!.getThemeColor()[300]!,
                        cubit.weatherModel!.getThemeColor()[100]!,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        Text(
                          WeatherCubit.instance(context).cityName??"",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'updated at : ${cubit.weatherModel!.date.hour.toString()}:${cubit.weatherModel!.date.minute.toString()}',
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(cubit.weatherModel!.getImage()),
                            Text(
                              cubit.weatherModel!.temp.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                    'maxTemp :${cubit.weatherModel!.maxTemp.toInt()}'),
                                Text(
                                    'minTemp : ${cubit.weatherModel!.minTemp.toInt()}'),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          cubit.weatherModel!.weatherStateName,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(
                          flex: 5,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
