import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class OrderCustomizationList extends StatefulWidget {
  const OrderCustomizationList({
    super.key,
    required this.titleName,
    this.isRequired = false,
    required this.listItems,
    required this.onValueChanged,
  });
  final String titleName;
  final List listItems;
  final bool isRequired;
  final ValueChanged<dynamic> onValueChanged;

  @override
  State<OrderCustomizationList> createState() => _OrderCustomizationListState();
}

class _OrderCustomizationListState extends State<OrderCustomizationList> {
  List value = [];
  dynamic groupValue;
  @override
  void initState() {
    value = widget.listItems;
    groupValue = widget.listItems[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 6,
          color: Colors.grey[200],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.titleName,
                    fontSize: 20,
                  ),
                  widget.isRequired
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const CustomText(
                            text: "Required",
                            color: Colors.grey,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.listItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: value[index],
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value;
                        widget.onValueChanged(groupValue);
                      });
                    },
                    title: CustomText(
                      text: widget.listItems[index],
                      fontSize: 17,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
