import 'package:flutter/material.dart';
import 'package:nasa_api/nasa_api.dart';

class NasaImageCardWidget extends StatelessWidget {
  const NasaImageCardWidget({
    Key? key,
    required this.nasaPhoto,
  }) : super(key: key);

  final NasaPhoto nasaPhoto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Hero(
              tag: nasaPhoto.nasaId,
              child: ClipRRect(
                child: Image.network(nasaPhoto.link),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            ListTile(title: Text(nasaPhoto.title)),
          ],
        ),
      ),
    );
  }
}
