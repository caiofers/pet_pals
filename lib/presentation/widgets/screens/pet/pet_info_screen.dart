import 'package:flutter/material.dart';
import 'package:pet_pals/domain/entities/pet_entity.dart';
import 'package:pet_pals/domain/entities/pet_tutor_entity.dart';
import 'package:pet_pals/presentation/bloc/app_localizations_bloc.dart';
import 'package:pet_pals/resources/assets/assets_path.dart';

class PetInfoScreen extends StatefulWidget {
  const PetInfoScreen({super.key, required this.pet});

  final Pet pet;

  @override
  State<PetInfoScreen> createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  final double appBarExpandedHeight = 300;

  late ScrollController _scrollController;
  late ImageProvider petImage;
  ColorFilter? petImageColorFilter;

  @override
  void initState() {
    super.initState();
    petImage = NetworkImage(widget.pet.imageUrl ?? "");

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  bool get _isSliverAppBarCollapsed {
    return _scrollController.hasClients &&
        _scrollController.offset > (appBarExpandedHeight - kToolbarHeight);
  }

  bool get _isAppBarTitleShowed {
    return _scrollController.hasClients &&
        _scrollController.offset > (appBarExpandedHeight + 50 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: false,
            pinned: true,
            expandedHeight: appBarExpandedHeight,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: petImage,
                      colorFilter: petImageColorFilter,
                      onError: (exception, stackTrace) {
                        setState(() {
                          petImageColorFilter =
                              ColorFilter.mode(Colors.black54, BlendMode.srcIn);
                          petImage = AssetImage(
                              "${AssetsPath.images}pet_img_placeholder@3x.png");
                        });
                      },
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _isSliverAppBarCollapsed ? 1.0 : 0,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Theme.of(context)
                        .appBarTheme
                        .backgroundColor
                        ?.withOpacity(1),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: AnimatedOpacity(
                        opacity: _isAppBarTitleShowed ? 1 : 0,
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          widget.pet.name,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: PetInfoData(
              pet: widget.pet,
            ),
          )
        ],
      ),
    );
  }
}

class PetInfoData extends StatelessWidget {
  const PetInfoData({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("${pet.type.name}, ${pet.breed}"),
                ],
              ),
              Container(
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
                        return Image.asset(
                            "${AssetsPath.images}pet_img_placeholder.png");
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PetAttribute(
                attributeTitle: AppLocalizationsBloc
                    .appLocalizations.petAttributeGenderText,
                attribute: pet.gender.name,
              ),
              PetAttribute(
                attributeTitle:
                    AppLocalizationsBloc.appLocalizations.petAttributeAgeText,
                attribute: pet.age,
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizationsBloc
                          .appLocalizations.petTutorsSectionTitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    //TextButton(onPressed: () {}, child: Text("Editar"))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 70,
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  mainAxisSpacing: 8,
                  crossAxisCount: 1,
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var tutor in pet.tutors) TutorPic(tutor: tutor),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizationsBloc
                          .appLocalizations.petAlarmsSectionTitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    //TextButton(onPressed: () {}, child: Text("Editar"))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 150,
                width: double.infinity,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      child: Container(
                        height: 200,
                        width: 300,
                      ),
                    ),
                    Card(
                      child: Container(
                        height: 200,
                        width: 300,
                      ),
                    ),
                    Card(
                      child: Container(
                        height: 200,
                        width: 300,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class PetAttribute extends StatelessWidget {
  const PetAttribute(
      {super.key, required this.attributeTitle, required this.attribute});

  final String attributeTitle;
  final String attribute;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 0.1,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(attributeTitle), Text(attribute)],
      ),
    );
  }
}

class TutorPic extends StatelessWidget {
  const TutorPic({
    super.key,
    required this.tutor,
  });

  final PetTutor tutor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Image.network(
            tutor.avatarUrl ?? '',
            errorBuilder: (context, error, stackTrace) {
              return CircleAvatar(child: Icon(Icons.person));
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            height: 20,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Colors.amber.shade200),
            child: Text(
              tutor.name.split(' ').first,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
