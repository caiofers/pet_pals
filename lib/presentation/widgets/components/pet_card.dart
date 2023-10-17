import 'package:flutter/material.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/resources/assets/assets_path.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
    required this.onCardTap,
    required this.onMoreOptionsPressed,
  });
  final Pet pet;
  final Function onCardTap;
  final Function onMoreOptionsPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () => onCardTap(),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image(
                    image: NetworkImage(pet.imageUrl ?? ""),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "${AssetsPath.images}pet_img_placeholder.png",
                        color: Colors.black54,
                        height: 200,
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              children: [Text("${pet.type.name}, ${pet.gender.name}")],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizationsBloc.appLocalizations.petCardAgeText(pet.age)),
                            Text(AppLocalizationsBloc.appLocalizations.petCardBreedText(pet.breed)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          onMoreOptionsPressed();
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 180, left: 16),
              height: 48,
              width: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black,
                  child: Image.asset(
                    pet.type.iconAssetName,
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("${AssetsPath.images}pet_img_placeholder.png");
                    },
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
