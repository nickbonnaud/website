import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'key_holder_cubit/key_holder_cubit.dart';
import 'parallax_bloc/parallax_bloc.dart';
import 'widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ParallaxBloc>(
            create: (_) => ParallaxBloc(),
          ),

          BlocProvider<KeyHolderCubit>(
            create: (_) => KeyHolderCubit()
          )
        ],
        child: const HomeScreenBody()
      )
    );
  }
}