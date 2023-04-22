// ignore_for_file: file_names

import '../Import&Export/export.dart';

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton(height: screenHeight / 6, width: screenWidth / 3.3),
        SizedBox(width: screenWidth / 75),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: screenWidth / 3.7),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              Row(
                children: [
                  const Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: screenWidth / 6),
                  const Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
