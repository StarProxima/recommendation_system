import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({
    Key? key,
    required this.onEditingComplete,
    required this.controller,
    required this.focus,
    this.backButton = false,
  }) : super(key: key);

  final VoidCallback onEditingComplete;
  final TextEditingController controller;
  final FocusNode focus;
  final bool backButton;
  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  void initState() {
    widget.focus.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: widget.controller,
        onEditingComplete: () {
          widget.focus.unfocus();
          widget.onEditingComplete();
        },
        textInputAction: TextInputAction.done,
        maxLines: 1,
        style: const TextStyle(fontSize: 17),
        textAlignVertical: TextAlignVertical.center,
        focusNode: widget.focus,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: widget.backButton
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 16),
          isDense: false,
          filled: true,
          fillColor: AppColors.divider,
          hintText: 'Искать',
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: widget.backButton
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                )
              : null,
          suffixIcon: widget.focus.hasFocus
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  onPressed: () {
                    widget.focus.unfocus();
                    if (widget.controller.text.isNotEmpty) {
                      widget.controller.clear();
                      widget.onEditingComplete();
                    }
                  },
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
