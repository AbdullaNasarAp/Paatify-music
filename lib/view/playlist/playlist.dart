import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:paatify/model/database.dart/playlistdb.dart';

import 'package:paatify/model/paatify_model.dart';
import 'package:paatify/view/playlist/playlistslist.dart';
import 'package:paatify/view/playlist/glass.dart';

class PlayListSc extends StatefulWidget {
  const PlayListSc({Key? key}) : super(key: key);

  @override
  State<PlayListSc> createState() => _PlayListScState();
}

final nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PlayListScState extends State<PlayListSc> {
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return ValueListenableBuilder(
      valueListenable: Hive.box<PaatifyMusic>('playlistDB').listenable(),
      builder:
          (BuildContext context, Box<PaatifyMusic> musicList, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black87,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Hive.box<PaatifyMusic>('playlistDB').isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lf30_editor_mhridpif.json",
                            height: 265, width: 365),
                        const Center(
                          child: Text(
                            'No PlayList Songs',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: musicList.length,
                      itemBuilder: (context, index) {
                        final data = musicList.values.toList()[index];
                        return ValueListenableBuilder(
                            valueListenable:
                                Hive.box<PaatifyMusic>('playlistDB')
                                    .listenable(),
                            builder: (BuildContext context,
                                Box<PaatifyMusic> musicList, Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return PlaylistData(
                                      playlist: data,
                                      folderindex: index,
                                    );
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: GlassMorphism(
                                    end: 0.5,
                                    start: 0.1,
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Lottie.asset(
                                              "assets/lf30_editor_js0djy4g.json",
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data.name,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                20.0,
                                                              ),
                                                            ),
                                                            elevation: 30,
                                                            backgroundColor:
                                                                Colors.white24,
                                                            title: const Text(
                                                              'Delete Playlist',
                                                            ),
                                                            content: const Text(
                                                                'Are you sure you want to delete this playlist?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                  'No',
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                                onPressed: () {
                                                                  musicList
                                                                      .deleteAt(
                                                                          index);
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('New playlist'),
            splashColor: Colors.transparent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Create New Playlist',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'New Playlist'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter playlist name";
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                        255,
                                        225,
                                        236,
                                        229,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        whenButtonClicked();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            backgroundColor: Colors.white,
            icon: const Icon(
              Icons.playlist_add,
            ),
          ),
        );
      },
    );
  }

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = PaatifyMusic(
        songId: [],
        name: name,
      );
      PlayListDB().playlistAdd(music);
      nameController.clear();
    }
  }
}
