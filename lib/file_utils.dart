import 'dart:io';

Future<void> replaceInFile(String path, oldPackage, newPackage) async {
  String contents = await readFileAsString(path);
  contents = contents.replaceAll(oldPackage, newPackage);
  await writeFileFromString(path, contents);
}

Future<String> readFileAsString(String path) async {
  var file = File(path);
  String contents;

  if (await file.exists()) {
    contents = await file.readAsString();
  }
  return contents;
}

Future<void> writeFileFromString(String path, String contents) async {
  var file = File(path);
  await file.writeAsString(contents);
}

Future<void> deleteOldDirectories(String lang, String oldPackage, String basePath) async {
  var dirList = oldPackage.split('.');
  var reversed = dirList.reversed.toList();

  for (int i = 0; i < reversed.length; i++) {
    String path = '$basePath$lang/' + dirList.join('/');

    if (Directory(path).listSync().toList().length == 0) {
      Directory(path).deleteSync();
    }
    dirList.removeLast();
  }
}