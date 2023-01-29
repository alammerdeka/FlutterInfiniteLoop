
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/playing.dart';

import 'api.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'NOW PLAYING',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          centerTitle: false,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: FutureBuilder(
          future: MovieRepository().getNowPlaying(1),
          builder: (BuildContext c, AsyncSnapshot s) {
            if (s.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return MovieList(
                playing: s.data,
              );
            }
          },
        ));

  }
}

class MovieList extends StatefulWidget {
  final Playing? playing;
  const MovieList({
     this.playing,
     Key? key,
  }) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  late List<Result> movie;
  int currentPage = 1;

  bool onNotificatin(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (kDebugMode) {
          print('End Scroll');
        }
        setState(() {
          isLoading =true;
        });
        MovieRepository().getNowPlaying(currentPage + 1).then((val) {
          currentPage = val.page!;
          setState(() {
            movie.addAll(val.results);
            isLoading =false;
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    movie = widget.playing!.results;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: onNotificatin,
        child: ListView.builder(
            itemCount: movie.length,
            controller: scrollController,
            itemBuilder: (BuildContext c, int i) {
              return Container(
                padding: EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                height: 300.0,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    image: DecorationImage(
                        image:movie[i].posterPath==null?NetworkImage('https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmxhbmslMjBhbmQlMjB3aGl0ZXxlbnwwfHwwfHw%3D&w=1000&q=80'):NetworkImage('https://image.tmdb.org/t/p/w500${movie[i].posterPath!}'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie[i].title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                    Expanded(
                      child: Container(),
                    ),

                  ],
                ),
              );
            }),
      ),
      bottomNavigationBar: isLoading?Container(height: 40, width: MediaQuery.of(context).size
          .width,child: Center(child: CircularProgressIndicator(),),):SizedBox(),);
  }
}
