import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_eats_clone/logic/cubits/restaurant_cubit/restaurant_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/restaurant_cubit/restaurant_state.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_icon_button.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';
import 'package:uber_eats_clone/presentation/widgets/features/home_screen/restaurant_listview.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(28.712743, 77.120044),
      infoWindow: InfoWindow(
        title: "La Pinos",
      ),
    ),
    const Marker(
      markerId: MarkerId("2"),
      position: LatLng(28.459496, 77.026638),
      infoWindow: InfoWindow(title: "Spicy Delight"),
    ),
    const Marker(
      markerId: MarkerId("3"),
      position: LatLng(28.586032, 77.044625),
      infoWindow: InfoWindow(title: "The Burger Joint"),
    ),
    const Marker(
      markerId: MarkerId("4"),
      position: LatLng(28.630453, 77.219763),
      infoWindow: InfoWindow(title: "Pizza Palace"),
    ),
    const Marker(
      markerId: MarkerId("5"),
      position: LatLng(28.481631, 77.088226),
      infoWindow: InfoWindow(title: "Sushi Central"),
    ),
    const Marker(
      markerId: MarkerId("6"),
      position: LatLng(28.621945, 77.087589),
      infoWindow: InfoWindow(title: "Tandoori Treats"),
    ),
    const Marker(
      markerId: MarkerId("7"),
      position: LatLng(28.554722, 77.234444),
      infoWindow: InfoWindow(title: "Italiano Vibes"),
    ),
    const Marker(
      markerId: MarkerId("8"),
      position: LatLng(28.644800, 77.189700),
      infoWindow: InfoWindow(title: "Biryani Bliss"),
    ),
    const Marker(
      markerId: MarkerId("9"),
      position: LatLng(28.572645, 77.324853),
      infoWindow: InfoWindow(title: "Fusion Fiesta"),
    ),
    const Marker(
      markerId: MarkerId("10"),
      position: LatLng(28.680089, 77.202951),
      infoWindow: InfoWindow(title: "Momo Magic"),
    ),
    const Marker(
      markerId: MarkerId("11"),
      position: LatLng(28.568585, 77.241508),
      infoWindow: InfoWindow(title: "Grill House"),
    ),
    const Marker(
      markerId: MarkerId("12"),
      position: LatLng(28.642022, 77.122287),
      infoWindow: InfoWindow(title: "Taste of China"),
    ),
    const Marker(
      markerId: MarkerId("13"),
      position: LatLng(28.541377, 77.156243),
      infoWindow: InfoWindow(title: "Healthy Bites"),
    ),
    const Marker(
      markerId: MarkerId("14"),
      position: LatLng(28.528800, 77.213800),
      infoWindow: InfoWindow(title: "Mexican Mania"),
    ),
    const Marker(
      markerId: MarkerId("15"),
      position: LatLng(28.556636, 77.206606),
      infoWindow: InfoWindow(title: "South Spice"),
    ),
    const Marker(
      markerId: MarkerId("16"),
      position: LatLng(28.494767, 77.088678),
      infoWindow: InfoWindow(title: "BBQ Nation"),
    ),
    const Marker(
      markerId: MarkerId("17"),
      position: LatLng(28.570138, 77.231350),
      infoWindow: InfoWindow(title: "Dessert Den"),
    ),
    const Marker(
      markerId: MarkerId("18"),
      position: LatLng(28.569796, 77.224450),
      infoWindow: InfoWindow(title: "Greek Gourmet"),
    ),
    const Marker(
      markerId: MarkerId("19"),
      position: LatLng(28.670070, 77.146252),
      infoWindow: InfoWindow(title: "Korean Kitchen"),
    ),
    const Marker(
      markerId: MarkerId("20"),
      position: LatLng(28.597378, 77.192732),
      infoWindow: InfoWindow(title: "The Pizzeria"),
    ),
  ];
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.5677781, 77.2034956),
    zoom: 10,
  );

  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            markers: Set<Marker>.of(_marker),
          ),
        ),
        Positioned(
          child: Container(
            color: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: "Now • New Delhi, Delhi ▾",
                  fontSize: 20,
                ),
                GapWidget(
                  horizontal: true,
                  size: 70,
                ),
                CustomIconButton(
                  iconName: "assets/icons/ic_filter.png",
                ),
                GapWidget(
                  horizontal: true,
                  size: -10,
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: MediaQuery.of(context).size.height * 0.43,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.white,
            child: SingleChildScrollView(
              child: BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoadingState &&
                      state.restaurants.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is RestaurantErrorState &&
                      state.restaurants.isEmpty) {
                    return Center(
                        child: CustomText(
                      text: state.message.toString(),
                    ));
                  }
                  return RestaurantListView(
                    inputList: state.restaurants,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
