import 'package:flutter/material.dart';
import 'package:style_packet/app_text_styles.dart';

class Remember extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool initialValue;

  const Remember({
    Key? key,
    required this.onChanged,
    this.initialValue = false,
  }) : super(key: key);

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _checked,
          activeColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onChanged: (bool? value) {
            setState(() {
              _checked = value ?? false;
              widget.onChanged(_checked);
            });
          },
          side: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        Text(
          "Ghi nhớ đăng nhập",
          style: AppTextStyles.bodyStrong.c(Colors.white),
        ),
      ],
    );
  }
}
