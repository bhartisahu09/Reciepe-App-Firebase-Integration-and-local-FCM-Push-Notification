// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:recipe_app/screens/home_screen.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   startTime() async {
//     var _duration = const Duration(seconds: 3);
//     return Timer(_duration, navigationPage);
//   }

//   void navigationPage() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => const HomeScreen(),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTime();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(32.5),
//         child: ListView(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.1,
//             ),
//             Container(
//               height: 213,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/img-onboarding.png'),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.05,
//             ),
//             const Text(
//               'Discover Delicious Recipes\nMade Just for You',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFF0E0E2D),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             const Text(
//               'explore step-by-step recipes,\nsave your favorites, and get cooking!',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color(0xff9A9DB0),
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.1,
//             ),
//             // Container(
//             //   height: 50,
//             //   decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.circular(26.5),
//             //     gradient: const LinearGradient(
//             //       begin: Alignment.topCenter,
//             //       end: Alignment.bottomCenter,
//             //       colors: [
//             //         Color(0xFFf6925c),
//             //         Color(0xFFf37552),
//             //       ],
//             //     ),
//             //   ),
//             //   child: const Center(
//             //     child: Text(
//             //       'Get Started',
//             //       style: TextStyle(
//             //         fontSize: 18,
//             //         color: Colors.white,
//             //         fontWeight: FontWeight.w600,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(height: 100),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) => const HomeScreen(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 elevation: 4,
//                 padding: EdgeInsets.zero,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(26.5),
//                 ),
//                 minimumSize: const Size(double.infinity, 50), // full width
//                 backgroundColor:
//                     Colors.transparent, // must be transparent for gradient
//                 shadowColor: Colors.transparent,
//               ),
//               child: Ink(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xFFf6925c),
//                       Color(0xFFf37552),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(26.5)),
//                 ),
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 50,
//                   child: const Text(
//                     'Get Started',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Container(
//             //   height: 50,
//             //   decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.circular(26.5),
//             //     color: Colors.white,
//             //   ),
//             //   child: const Center(
//             //     child: Text(
//             //       'Amazing Reciepe See',
//             //       style: TextStyle(
//             //         fontSize: 18,
//             //         fontWeight: FontWeight.w600,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    await setFirstLaunchFalse();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> setFirstLaunchFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstLaunch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.5),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              height: 213,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img-onboarding.png'),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const Text(
              'Discover Delicious Recipes\nMade Just for You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0E0E2D),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const Text(
              'Explore step-by-step recipes,\nsave your favorites, and get cooking!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff9A9DB0),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
              onPressed: () async {
                await setFirstLaunchFalse();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 4,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.5),
                ),
                minimumSize: const Size(double.infinity, 50), // full width
                backgroundColor: Colors.transparent, // for gradient
                shadowColor: Colors.transparent,
              ),
              child: Ink(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFf6925c),
                      Color(0xFFf37552),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(26.5)),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
