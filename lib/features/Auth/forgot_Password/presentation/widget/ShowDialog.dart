import 'package:flutter/material.dart';

class ShowDialogWidget extends StatelessWidget {
   ShowDialogWidget({super.key,required this.mSG});
  final String mSG;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   'assets/images/warning.png',
        //   height: 70,
        // ),
        const SizedBox(
          height: 15,
        ),
         Text(
          mSG,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const SizedBox(
          height: 15,
        ),
        OutlinedButton(
          child: const Text('Ok'),
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              // side: const BorderSide(width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          onPressed: () {},
        ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       OutlinedButton(
        //         child: Tex  t('Cancel'),
        //         style: OutlinedButton.styleFrom(
        //             padding: const EdgeInsets.all(5),
        //             // side: const BorderSide(width: 1),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(16))),
        //         onPressed: () {},
        //       ),
        //       OutlinedButton(
        //         child: Text('Ok'),
        //         style: OutlinedButton.styleFrom(
        //             padding: const EdgeInsets.all(5),
        //             // side: const BorderSide(width: 1),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(16))),
        //         onPressed: () {},
        //       ),
        //     ],
        //   )
      ],
    );
  }
}
