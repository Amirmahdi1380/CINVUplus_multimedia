import 'package:connectplus/config/theme.dart';
import 'package:connectplus/domain/entities/feature.dart';
import 'package:connectplus/presentation/screens/event_form_screen.dart';
import 'package:connectplus/presentation/screens/web_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureItemWidget extends StatelessWidget {
  final Feature feature;

  const FeatureItemWidget({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    // final Shader linearGradient = LinearGradient(
    //   colors: <Color>[
    //     feature.iconColor!.withOpacity(0.2),
    //     feature.iconColor!.withOpacity(0.5)
    //   ],
    // ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return GestureDetector(
      onTap: () {
        if (feature.isEnable && feature.siteUrl != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) {
                if (feature.label == "Events") {
                  return const EventFormScreen();
                } else {
                  return WebViewScreen(
                      url: feature.siteUrl!, label: feature.label);
                }
              }),
            ),
          );
        }
        if (!feature.isEnable) {
          final snackBar = SnackBar(
            backgroundColor: primaryColor,
            content: Text(
              '${feature.label} is available soon...',
              style: const TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        margin: EdgeInsets.all(smallDistance),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 2,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
          gradient: (feature.isEnable)
              ? LinearGradient(
                  colors: [
                    feature.iconColor!.withOpacity(0.24),
                    feature.iconColor!.withOpacity(0.05)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(colors: [
                  Colors.grey.withOpacity(0.3),
                  Colors.grey.withOpacity(0.3)
                ]),
          color:
              (feature.isEnable) ? Colors.white : Colors.grey.withOpacity(0.3),
          border: Border.all(
            width: 1,
            color: (feature.isEnable)
                ? primaryColor.withOpacity(0.1)
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(largeRadius),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: smallDistance),
                child: Opacity(
                  opacity: (feature.isEnable) ? 1 : 0.35,
                  child: SvgPicture.asset(
                    'assets/images/cinvu-logo.svg',
                    height: 32,
                    width: 32,
                    color: (feature.isEnable) ? feature.iconColor : Colors.grey,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: smallDistance),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: (feature.isEnable) ? 1 : 0.5,
                        child: Icon(
                          feature.icon,
                          color: feature.iconColor?.withOpacity(0.8),
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        feature.label,
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = (feature.isEnable)
                                ? LinearGradient(
                                    colors: <Color>[
                                      feature.iconColor!.withOpacity(1),
                                      feature.iconColor!.withOpacity(0.8),
                                      feature.iconColor!.withOpacity(0.3),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                  ).createShader(const Rect.fromLTWH(
                                    200.0, 0.0, 200.0, 100.0))
                                : LinearGradient(
                                    colors: <Color>[
                                      Theme.of(context)
                                          .canvasColor
                                          .withOpacity(0.3),
                                      Theme.of(context)
                                          .canvasColor
                                          .withOpacity(0.3),
                                      Theme.of(context)
                                          .canvasColor
                                          .withOpacity(0.3)
                                    ],
                                  ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                                  ),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
