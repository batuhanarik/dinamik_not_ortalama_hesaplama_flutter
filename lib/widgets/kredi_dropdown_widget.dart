import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';

class KrediDropdownWidget extends StatefulWidget {
  final Function onSelectedKredi;
  KrediDropdownWidget({required this.onSelectedKredi,Key? key}) : super(key: key);

  @override
  State<KrediDropdownWidget> createState() => _KrediDropdownWidgetState();
}

class _KrediDropdownWidgetState extends State<KrediDropdownWidget> {
  double secilenKrediDegeri = 1;
  @override
  Widget build(BuildContext context) {
   return Container(
      alignment: Alignment.center,
      padding: Constants.dropDownPadding,
      decoration: BoxDecoration(
        color: Constants.mainColor.shade100.withOpacity(0.3),
        borderRadius: Constants.borderRadius,
      ),
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        iconEnabledColor: Constants.mainColor.shade200,
        onChanged: (deger) {
          setState(() {
            secilenKrediDegeri = deger!;
            widget.onSelectedKredi(deger);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }
}