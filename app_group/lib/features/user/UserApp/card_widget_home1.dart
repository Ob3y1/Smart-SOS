import 'package:flutter/material.dart';

class CardWidgetHome1 extends StatelessWidget {
  final int requestStatus;
  final bool activeTextFromField;
  final String type;
  final String carNumber;
  final String site;

  const CardWidgetHome1({
    super.key,
    required this.activeTextFromField,
    required this.type,
    required this.carNumber,
    required this.site,
    required this.requestStatus,
  });

  @override
  Widget build(BuildContext context) {
    // Determine step statuses based on requestStatus
    bool step1 = requestStatus >= 1;
    bool step2 = requestStatus >= 2;
    bool step3 = requestStatus >= 3;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, left: 0, right: 0),
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("نوع الطلب: $type"),
                Text("رقم السيارة: $carNumber"),
                Text("المركز: $site"),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            steps: [
              Step(
                isActive: step1,
                title: const SizedBox.shrink(),
                subtitle: const Text('تم الارسال'),
                content: const SizedBox.shrink(),
                state: step1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                isActive: step2,
                title: const SizedBox.shrink(),
                subtitle: const Text('المساعدة في الطريق'),
                content: const SizedBox.shrink(),
                state: step2 ? StepState.complete : StepState.indexed,
              ),
              Step(
                isActive: step3,
                title: const SizedBox.shrink(),
                subtitle: const Text('تم انهاء العمل '),
                content: const SizedBox.shrink(),
                state: step3 ? StepState.complete : StepState.indexed,
              ),
            ],
          ),
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: TextFormField(
        //           style: TextStyle(
        //               color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
        //               fontWeight: FontWeight.bold),
        //           cursorColor: const Color.fromARGB(255, 0, 0, 0),
        //           enabled: activeTextFromField,
        //           decoration: InputDecoration(
        //             border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(9)),
        //             hintText: 'Add your notes here',
        //             hintStyle: TextStyle(
        //                 fontSize: 14,
        //                 color: const Color.fromARGB(255, 0, 0, 0)
        //                     .withOpacity(.5)),
        //           ),
        //         ),
        //       ),
        //     ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const Home(),
            //         ),
            //         (route) => false,
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.black, // Button color
            //     ),
            //     child: const Text(
            //       'إرسال',
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
        //   ],
        // ),
      ],
    );
  }
}
