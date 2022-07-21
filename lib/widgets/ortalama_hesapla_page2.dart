import 'package:dinamik_not_ortalama_hesaplama/constants/app_constants.dart';
import 'package:dinamik_not_ortalama_hesaplama/helper/data_helper.dart';
import 'package:dinamik_not_ortalama_hesaplama/model/ders.dart';
import 'package:dinamik_not_ortalama_hesaplama/widgets/ders_listesi.dart';
import 'package:dinamik_not_ortalama_hesaplama/widgets/harf_dropdown_widget.dart';
import 'package:dinamik_not_ortalama_hesaplama/widgets/kredi_dropdown_widget.dart';
import 'package:dinamik_not_ortalama_hesaplama/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage2 extends StatefulWidget {
  OrtalamaHesaplaPage2({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaPage2> createState() => _OrtalamaHesaplaPage2State();
}

class _OrtalamaHesaplaPage2State extends State<OrtalamaHesaplaPage2> {
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
          Expanded(
            child: DersListesi(
              onDismiss : (index){ 
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
                print('Eleman çıkarıldı index ${index}');
              },
            ),
          ),
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
                    child: HarfDropdownWidget(
                      onSelectedLetter:(harf){
                        secilenHarfDegeri = harf;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: Constants.yatayPadding8,
                    child: KrediDropdownWidget(
                      onSelectedKredi: (kredi){
                        secilenKrediDegeri = kredi;
                      },
                    ),
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
        hintText: 'Mathematics',
        border: OutlineInputBorder(
          borderRadius: Constants.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Constants.mainColor.shade100.withOpacity(0.3),
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