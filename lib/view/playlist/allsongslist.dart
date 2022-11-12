import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/provider/playlistprovider/allsongslistprovider.dart';
import 'package:paatify/model/database.dart/playlistdb.dart';
import 'package:paatify/model/paatify_model.dart';
import 'package:provider/provider.dart';

class SongListPage extends StatelessWidget {
  SongListPage({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final PaatifyMusic playlist;

  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AllSongsListProvider>(context).notifyListeners();
    return Consumer(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: const Text(
                'Add Songs',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: FutureBuilder<List<SongModel>>(
                  future: audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true),
                  builder: (context, item) {
                    if (item.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    if (item.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Songs Found',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                              onTap: () {},
                              iconColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              textColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              leading: QueryArtworkWidget(
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.075,
                                  backgroundColor:
                                      const Color.fromARGB(255, 43, 42, 42),
                                  child: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ),
                                ),
                                artworkFit: BoxFit.fill,
                                artworkBorder:
                                    const BorderRadius.all(Radius.circular(0)),
                              ),
                              title: Text(
                                item.data![index].displayNameWOExt,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                "${item.data![index].artist}",
                                maxLines: 1,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    playlistCheck(item.data![index], context);
                                    provider;
                                    PlayListDB()
                                        .playlistnotifier
                                        .notifyListeners();
                                  },
                                  icon: playlist.inValueIn(item.data![index].id)
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  color:
                                      playlist.inValueIn(item.data![index].id)
                                          ? Colors.green
                                          : Colors.red));
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: item.data!.length);
                  }),
            ));
      },
    );
  }

  void playlistCheck(SongModel data, context) {
    if (!playlist.inValueIn(data.id)) {
      playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Added to Playlist',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 250));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      playlist.deleteData(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Removed from Playlist',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 250));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
