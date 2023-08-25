import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/top_headline_provider.dart';
import 'package:news_app/widget/list_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'sidebar.dart';

enum FilterList { bbc, ary, aljazeera }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TopHeadlineProvider>(context, listen: false)
        .getTopHeadline("bbc-news");
  }

  FilterList? selectedMenu;
  TextEditingController search = TextEditingController();

  final format = DateFormat('H');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Image(
          image: AssetImage("assets/news_splash_logo.png"),
          width: 100,
          height: 50,
        ),

        actions: [
          Consumer<TopHeadlineProvider>(
            builder: (_, value, __) => PopupMenuButton(
              color: Colors.white,
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                const PopupMenuItem<FilterList>(
                    value: FilterList.bbc, child: Text("BBC News")),
                const PopupMenuItem<FilterList>(
                    value: FilterList.ary, child: Text("ARY News")),
                const PopupMenuItem<FilterList>(
                    value: FilterList.aljazeera, child: Text("AlJazeera News"))
              ],
              onSelected: (FilterList item) {
                if (FilterList.bbc.name == item.name) {
                  String name = "bbc-news";
                  value.getTopHeadline(name);
                }
                if (FilterList.ary.name == item.name) {
                  String name = "ary-news";
                  value.getTopHeadline(name);
                }
                if (FilterList.aljazeera.name == item.name) {
                  String name = "al-jazeera-english";
                  value.getTopHeadline(name);
                }
              },
            ),
          )
        ],
      ),
      body: SizedBox(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: search,
            decoration: const InputDecoration(
                labelText: "Search", suffixIcon: Icon(Icons.search)),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Top Headlines",
              style: GoogleFonts.playfairDisplay(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 10, left: 13.5, right: 15),
                width: size.width,
                child: Consumer<TopHeadlineProvider>(
                  builder: (_, value, __) {
                    if (value.loader) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return NewsTile(details: value.topheadline[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: value.topheadline.length);
                  },
                )),
          )
        ]),
      ),
    );
  }
}
