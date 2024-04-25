import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/controller/provider/favoritepro/favoriteprovider.dart';
import 'package:paatify/view/nowplaying.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/99403-love.json", height: 35, width: 35),
            const Text(
              "Favorites",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<FavoritesProvider>(
          builder: (context, provider, _) {
            List<SongModel> favorData = provider.favoriteSongs;

            return favorData.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/repRmRA5JM.json",
                            height: 265, width: 365),
                        const Text(
                          'No Favorites songs',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: favorData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          List<SongModel> favList = [...favorData];
                          GetSongs.player.stop();
                          GetSongs.player.setAudioSource(
                              GetSongs.createSongList(favList),
                              initialIndex: index);
                          GetSongs.player.play();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => NowPlaying(
                                playerSong: favList,
                              ),
                            ),
                          );
                        },
                        leading: QueryArtworkWidget(
                          id: favorData[index].id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.circular(0),
                          nullArtworkWidget: CircleAvatar(
                            child: Lottie.asset('assets/listnull.json'),
                          ),
                        ),
                        title: Text(
                          favorData[index].displayNameWOExt,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        subtitle: Text(
                          favorData[index].artist.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            provider.deleteFavorite(favorData[index].id);
                          },
                          icon: const Icon(FontAwesomeIcons.trash),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
          },
        ),
      ),
    );
  }
}
