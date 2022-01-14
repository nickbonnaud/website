import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'parallax_bloc/parallax_bloc.dart';
import 'widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ParallaxBloc>(
        create: (_) => ParallaxBloc(),
        child: HomeScreenBody(),
      )
    );
  }
}