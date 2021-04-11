import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:genetic_algorithms/shared/exceptions.dart';
import 'package:genetic_algorithms/shared/platforms.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'save_to_file_event.dart';
part 'save_to_file_state.dart';

class SaveToFileBloc extends Bloc<SaveToFileEvent, SaveToFileState> {
  SaveToFileBloc() : super(SaveToFileInitialState());

  @override
  Stream<SaveToFileState> mapEventToState(
    SaveToFileEvent event,
  ) async* {
    if (event is SaveToFileDataEvent) {
      try {
        yield SaveToFileInProgressState();

        File file = await initFile();
        saveEpochToFile(event.chromosomesInEachEpoch, file);

        yield SaveToFileSuccesfullState();
      } catch (e) {
        yield SaveToFileFailureState(FileError.UNDEFINED, "");
      }
    }
  }

  Future<File> initFile() async {
    String tempName = 'genetic-algorith-results-';

    Directory mainDir = (PlatformInfo.isMobile
        ? await getApplicationDocumentsDirectory()
        : await getDownloadsDirectory())!;

    Directory fileDirectory = await mainDir.createTemp(tempName);

    String path = join(fileDirectory.path, 'each_epoch.txt');

    return File(path);
  }

  void saveEpochToFile(List<List<double>> chromosomesInEachEpoch, File file) {
    for (var i = 0; i < chromosomesInEachEpoch.length; i++) {
      file.writeAsStringSync('Epoch $i\n', mode: FileMode.append);
      chromosomesInEachEpoch[i].forEach((double element) {
        file.writeAsStringSync(element.toString(), mode: FileMode.append);
        file.writeAsStringSync('\n', mode: FileMode.append);
      });
    }

    file.writeAsStringSync('\n\n', mode: FileMode.append);
  }
}
