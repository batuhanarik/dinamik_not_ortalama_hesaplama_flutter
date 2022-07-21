import 'package:dinamik_not_ortalama_hesaplama/constants/app_constants.dart';
import 'package:dinamik_not_ortalama_hesaplama/helper/data_helper.dart';
import 'package:flutter/material.dart';

class HarfDropdownWidget extends StatefulWidget {
  final Function onSelectedLetter;
  HarfDropdownWidget({required this.onSelectedLetter,Key? key}) : super(key: key);

  @override
  State<HarfDropdownWidget> createState() => _nameState();
}

class _nameState extends State<HarfDropdownWidget> {
  double secilenHarfDegeri = 4;

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
        value: secilenHarfDegeri,
        elevation: 16,
        iconEnabledColor: Constants.mainColor.shade200,
        onChanged: (deger) {
          setState(() {
            secilenHarfDegeri = deger!;
            widget.onSelectedLetter(secilenHarfDegeri);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinHarfleri(),
      ),
    );
  }
}