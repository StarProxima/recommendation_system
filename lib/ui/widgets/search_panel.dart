import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key, required this.onEditingComplete})
      : super(key: key);

  final Function(String query) onEditingComplete;
  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  FocusNode focus = FocusNode();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        onEditingComplete: () {
          widget.onEditingComplete(controller.text);
        },
        maxLines: 1,
        style: const TextStyle(fontSize: 17),
        textAlignVertical: TextAlignVertical.center,
        focusNode: focus,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: false,
          filled: true,
          fillColor: AppColors.divider,
          hintText: 'Искать',
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ],
            ),
          ),
          suffixIcon: focus.hasFocus
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  onPressed: () {
                    focus.unfocus();
                    // if (nameController.text.isNotEmpty) {
                    //   nameController.clear();
                    //   widget.onEditiningComplite(nameController.text);
                    // }
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
