import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../constant/const.dart';

class CaroselCustom extends StatefulWidget {
  const CaroselCustom({
    Key? key,
  }) : super(key: key);

  @override
  State<CaroselCustom> createState() => _CaroselCustomState();
}

//Class of Carousel
class _CaroselCustomState extends State<CaroselCustom> {
  final _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true),
      builder: (context, item) {
        if (item.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (item.data!.isEmpty) {
          return const Center(
            child: Text(
              'No Songs Found',
            ),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                // height: 15,
                child: CarouselSlider.builder(
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        GestureDetector(
                          onTap: () {
                            GetSongs.player.setAudioSource(
                                GetSongs.createSongList(item.data!),
                                initialIndex: itemIndex);
                            GetSongs.player.play();
                            setState(() {});

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NowPlaying(playerSong: item.data!)),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              QueryArtworkWidget(
                                keepOldArtwork: true,
                                quality: 100,
                                id: item.data![itemIndex].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: CircleAvatar(
                                    radius: 30,
                                    child:
                                        Lottie.asset('assets/listnull.json')),
                                artworkBorder: const BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                                artworkWidth:
                                    MediaQuery.of(context).size.width * 0.3,
                                artworkHeight: 65,
                              ),
                              Text(
                                item.data![itemIndex].displayNameWOExt,
                                style: const TextStyle(
                                  fontFamily: family,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                "${item.data![itemIndex].artist}",
                                style: const TextStyle(
                                    fontSize: 13, fontFamily: 'Segoe UI'),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ),
                    options: CarouselOptions(
                      height: 160,
                      viewportFraction: 0.4,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInQuint,
                      enlargeCenterPage: true,
                    ),
                    itemCount: 10),
              ),
            ],
          );
        }
      },
    );
  }
}

//Custom Text
class TExt extends StatelessWidget {
  final String teXt;
  const TExt({
    Key? key,
    required this.teXt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      teXt,
      style: const TextStyle(
        fontFamily: 'Segoe UI',
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
    );
  }
}

//Custom SubText
class Sub extends StatelessWidget {
  final String sub;
  const Sub({
    Key? key,
    required this.sub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sub,
      style: const TextStyle(
          fontFamily: 'Segoe UI', fontSize: 15, fontWeight: FontWeight.w300),
      maxLines: 1,
    );
  }
}
