 import 'package:awesome_dialog/awesome_dialog.dart';

awesonDialogWidget(context , desc){
AwesomeDialog(
  
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: desc,
       ).show();
 }