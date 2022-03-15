import 'package:cothinker/constants.dart';
import 'package:flutter/material.dart';

class HeaderScreen extends StatelessWidget {
  const HeaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding * 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                    filterQuality: FilterQuality.high,
                    image: AssetImage("assets/cothinker_profil.png"),
                    fit: BoxFit.cover)),
            height: 40,
            width: 40,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding / 1.5)),
          const Text(
            "Hallo,  Gertrud!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          const Spacer(),
          InkWell(
            child: const Icon(
              Icons.logout_rounded,
              size: 20,
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
