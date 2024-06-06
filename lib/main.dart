import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uber_eats_clone/logic/cubits/product_cubit/product_cubit.dart';
import 'package:uber_eats_clone/logic/provider/cart_provider.dart';
import 'package:uber_eats_clone/presentation/pages/auth/landing_page.dart';
import 'package:uber_eats_clone/firebase_options.dart';
import 'package:uber_eats_clone/presentation/pages/home.dart';
import 'package:uber_eats_clone/logic/cubits/restaurant_cubit/restaurant_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_state.dart';
import 'package:uber_eats_clone/core/custom_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => RestaurantCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<UserCubit, UserState>(
            buildWhen: (previous, current) {
              return previous is UserInitialState;
            },
            builder: (context, state) {
              if (state is UserLoggedInState) {
                return Home();
              } else if (state is UserLoggedOutState) {
                return const LandingPage();
              }
              return const Scaffold();
            },
          ),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Color.fromRGBO(75, 164, 87, 1),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: CustomTextStyle.mediumText.copyWith(
                color: Colors.black,
              ),
            ),
            textTheme: TextTheme(
              bodyLarge: CustomTextStyle.mediumText,
              bodyMedium: CustomTextStyle.mediumText,
              bodySmall: CustomTextStyle.mediumText,
              headlineLarge: CustomTextStyle.boldText,
              headlineMedium: CustomTextStyle.boldText,
            ),
          ),
        ),
      ),
    );
  }
}
