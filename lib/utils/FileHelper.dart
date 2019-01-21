part of '../attion_flutter_tools.dart';


class FileHelper{
  // _getLocalFile函数，获取本地文件目录
  static Future<File> getLocalFile(String fileName) async {
    // 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    // 返回本地文件目录
    return new File('$dir/'+fileName);
  }

  static Future<String> readLocalFileAsString(String fileName) async {
    var file= await getLocalFile(fileName);
    if(!(await file.exists())){
      return null;
    }
    return await file.readAsString();
  }

  static Future writeLocalFileAsString(String fileName,String contents) async {
    var file= await getLocalFile(fileName);
    if(await file.exists()){
      await file.delete();
    }
    await file.writeAsString(contents);
  }


}