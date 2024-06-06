import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';

class BrowseSearchButton extends StatelessWidget {
  const BrowseSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(border: Border.all()),
          child: const Center(
            child: CustomText(
              text: "BROWSE OR SEARCH",
              fontSize: 20,
            ),
          ),
        ),
        const GapWidget(),
        const Center(
          child: CustomText(
            text: "SEE ALL RESTAURANTS",
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const GapWidget(),
        const Padding(
          padding: EdgeInsets.all(15),
          child: CustomText(
            text:
                "Uber is paid by merchants for marketing and promotiion, which influences the personalised recommendations you see.",
            fontSize: 18,
          ),
        ),
        const GapWidget(),
      ],
    );
  }
}
