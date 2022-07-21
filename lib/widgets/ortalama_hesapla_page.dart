import 'package:dinamik_not_ortalama_hesaplama/constants/app_constants.dart';
import 'package:dinamik_not_ortalama_hesaplama/helper/data_helper.dart';
import 'package:dinamik_not_ortalama_hesaplama/model/ders.dart';
import 'package:dinamik_not_ortalama_hesaplama/widgets/ders_listesi.dart';
import 'package:dinamik_not_ortalama_hesaplama/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  var formKey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(Constants.titleText, style: Constants.titleStyle),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(dersSayisi: DataHelper.tumEklenenDersler.length, ortalama: DataHelper.ortalamaHesapla()),
              ),
            ],
          ),
          // Expanded(
          //   child: DersListesi(),
          // ),
          //liste
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: Constants.yatayPadding8,
              child: _buildTextFormField(),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: Constants.yatayPadding8,
                    child: _buildHarfler(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: Constants.yatayPadding8,
                    child: _buildKrediler(),
                  ),
                ),
                IconButton(
                  onPressed: _dersEkleVeOrtalamaHesapla,
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  color: Constants.mainColor,
                  iconSize: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ));
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return 'Ders Adini Giriniz';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        //ipucu metni
        hintText: 'Ders Adı...',
        border: OutlineInputBorder(
          borderRadius: Constants.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Constants.mainColor.shade100.withOpacity(0.3),
      ),
    );
  }

  _buildHarfler() {
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
            // print(deger);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinHarfleri(),
      ),
    );
  }

  _buildKrediler() {
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
            // print(deger);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }

  void _dersEkleVeOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);


      DataHelper.dersEkle(eklenecekDers);
      setState(() {
        
      });
      print(DataHelper.ortalamaHesapla());
    }
  }
}
