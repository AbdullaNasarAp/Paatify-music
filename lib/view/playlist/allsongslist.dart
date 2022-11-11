import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/database.dart/playlistdb.dart';
import 'package:paatify/model/paatify_model.dart';

class SongListPage extends StatefulWidget {
  const SongListPage({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final PaatifyMusic playlist;
  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
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
                        iconColor: const Color.fromARGB(255, 255, 255, 255),
                        textColor: const Color.fromARGB(255, 255, 255, 255),
                        leading: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.075,
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
                              setState(() {
                                playlistCheck(item.data![index]);

                                // playlistnotifier.notifyListeners();
                                PlayListDB().playlistnotifier.notifyListeners();
                              });
                            },
                            icon:
                                !widget.playlist.inValueIn(item.data![index].id)
                                    ? const Icon(Icons.add)
                                    : const Icon(Icons.check)),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider();
                    },
                    itemCount: item.data!.length);
              }),
        ));
  }

  void playlistCheck(SongModel data) {
    if (!widget.playlist.inValueIn(data.id)) {
      widget.playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'song Added to Playlist',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
