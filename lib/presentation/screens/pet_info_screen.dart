import 'package:flutter/material.dart';
import 'package:pet_pals/models/pet.dart';

class PetInfoScreen extends StatefulWidget {
  const PetInfoScreen({super.key, required this.pet});

  final Pet pet;

  @override
  State<PetInfoScreen> createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  final double appBarExpandedHeight = 200;

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  bool get _isSliverAppBarCollapsed {
    return _scrollController.hasClients &&
        _scrollController.offset > (appBarExpandedHeight - kToolbarHeight);
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
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.pet.image),
                    ),
                  ),
                ),
                AnimatedOpacity(
                    opacity: _isSliverAppBarCollapsed ? 1.0 : 0,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      color: Theme.of(context)
                          .appBarTheme
                          .backgroundColor
                          ?.withOpacity(1),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: Text(
                      widget.pet.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: PetInfoData())
        ],
      ),
    );
  }
}

class PetInfo extends StatelessWidget {
  const PetInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          PetInfoData(),
        ],
      ),
    );
  }
}

class PetInfoData extends StatelessWidget {
  const PetInfoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Dados do animal"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Divider(),
          Text("Tutores"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Divider(),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Divider(),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Divider(),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Histórico"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
          Text("Nome: Cacau"),
        ],
      ),
    );
  }
}
