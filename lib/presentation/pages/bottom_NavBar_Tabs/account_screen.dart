import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uber_eats_clone/presentation/pages/auth/landing_page.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_state.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<IconData> icons = [
    Iconsax.book,
    Iconsax.heart,
    Iconsax.star,
    Iconsax.wallet,
    Iconsax.gift,
    Iconsax.bag,
    Iconsax.support,
    Iconsax.lamp,
    Iconsax.ticket,
    Iconsax.bag,
    Iconsax.setting,
  ];
  List<String> iconLabel = [
    "Orders",
    "Your favourites",
    "Restaurant Rewards",
    "Wallet",
    "Send a gift",
    "Business preferences",
    "Help",
    "Promotions",
    "Uber Pass",
    "Deliver with Uber",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            CircleAvatar(),
            GapWidget(
              horizontal: true,
              size: -10,
            ),
            CustomText(
              text: "John Doe",
              fontSize: 20,
            ),
          ],
        ),
        actions: [
          BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingPage(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Iconsax.logout),
                onPressed: () {
                  BlocProvider.of<UserCubit>(context).signOut();
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(icons[index]),
            title: CustomText(text: iconLabel[index]),
          );
        },
      ),
    );
  }
}
