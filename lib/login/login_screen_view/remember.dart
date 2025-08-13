import 'package:flutter/material.dart';

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
        Container(
          child: Checkbox(
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
        ),
        const Text("Ghi nhớ đăng nhập",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ],
    );
  }
}
