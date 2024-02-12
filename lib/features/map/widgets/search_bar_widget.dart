import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_watt/core/build_form_field.dart';
import 'package:task_watt/features/map/controller/search_location_controller.dart';

const textDirection = TextDirection.ltr;

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _emailFocusNode = FocusNode();
  final SearchLocationController searchLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        if (_focusScopeNode.hasFocus) {
          _focusScopeNode.unfocus();
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: Container(
          height: mediaQuery.height * 0.10,
          width: mediaQuery.width,
          color: Theme.of(context).colorScheme.onInverseSurface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildFormField(
                  textDirection: textDirection,
                  fieldName: "Search for locations",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: _emailFocusNode,
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus();
                  },
                  validator: (value) {},
                  onChanged: (value) {
                    searchLocationController.getPredictionPlacesFromSearch(value);
                  },
                  onSaved: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
