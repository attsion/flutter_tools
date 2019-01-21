part of '../attion_flutter_tools.dart';

class AppGlobalState extends Model with AppPackageInfo, DeviceInfo {
  static const baseUrl='http://10.0.2.2:13834';//"http://eeqg-server.com:8888";
  final String urlStatiPrimary = baseUrl+"/api/stat";
  final String urlStatiSecond = baseUrl+"/api/stat";
  final String urlUploadPrimary = baseUrl+"/api/upload";
  final String urlUploadSecond = baseUrl+"/api/upload";

  AppUploadInfo uploadInfo;

  init() async {
    await readVersion();
    await readDevice();
    await _checkUpload();
    notifyListeners();

    _runStatics();
  }


  static AppGlobalState of(context) => ScopedModel.of<AppGlobalState>(context,rebuildOnChange: true);

  _runStatics() async {
    var formData = {};
    try {
      formData = FormData.from({
        "appName":packageInfo.appName,
        "version": packageInfo.version,
        "androidInfo_version": androidInfo?.version,
        "androidInfo_model": androidInfo?.model,
        "androidInfo_androidId": androidInfo?.androidId,
        "androidInfo_board": androidInfo?.board,
        "androidInfo_bootloader": androidInfo?.bootloader,
        "androidInfo_brand": androidInfo?.brand,
        "androidInfo_device": androidInfo?.device,
        "androidInfo_display": androidInfo?.display,
        "androidInfo_fingerprint": androidInfo?.fingerprint,
        "androidInfo_hardware": androidInfo?.hardware,
        "androidInfo_host": androidInfo?.host,
        "androidInfo_id": androidInfo?.id,
        "androidInfo_manufacturer": androidInfo?.manufacturer,
        "androidInfo_product": androidInfo?.product,
        "androidInfo_tags": androidInfo?.tags,
        "androidInfo_type": androidInfo?.type,
        "androidInfo_isPhysicalDevice": androidInfo?.isPhysicalDevice,
      });
    } catch (exception) {
      print("信息收集错误");
      return;
    }
    try {
      var response = await Dio().post(urlStatiPrimary,
          data: formData,
          options: Options(
            connectTimeout: 3000,
            receiveTimeout: 3000,
          ));
      print(response.toString());
    } catch (ex) {
      print("url failed" + ex.toString());

      try {
        var response = await Dio().post(urlStatiSecond,
            data: formData,
            options: Options(
              connectTimeout: 3000,
              receiveTimeout: 3000,
            ));
        print(response.toString());
      } catch (ex) {
        print("ip failed" + ex.toString());
        print(ex);
      }
    }


  }

  _checkUpload() async {
    var formData = {};
    try {
      formData = FormData.from({
        "appName": packageInfo.appName,
        "version": packageInfo.version,
      });
    } catch (exception) {
      print("信息收集错误");
      return;
    }
    try {
      var response = await Dio().post(urlUploadPrimary,
          data: formData,
          options: Options(
            connectTimeout: 3000,
            receiveTimeout: 3000,
          ));

      uploadInfo= AppUploadInfo.fromJson(response.data);
    } catch (ex) {
      print("url upload failed" + ex.toString());

      try {
        var response = await Dio().post(urlUploadSecond,
            data: formData,
            options: Options(
              connectTimeout: 3000,
              receiveTimeout: 3000,
            ));
        uploadInfo= AppUploadInfo.fromJson(response.data);
      } catch (ex) {
        print("ip upload failed" + ex.toString());
        print(ex);
      }
    }
  }
}

class AppPackageInfo {
  PackageInfo packageInfo;

  readVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}

class DeviceInfo {
  AndroidDeviceInfo androidInfo;
  IosDeviceInfo iosInfo;

  readDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }
  }
}

class AppUploadInfo {
  bool hasNewVersion;

  String appName;
  String currentVersion;
  String newVersion;
  String newVersionIntroduce;
  String path;

  AppUploadInfo.fromJson(Map<String, dynamic> map){

    this.hasNewVersion=map['hasNewVersion'];
    this.appName=map['appName'];
    this.currentVersion=map['currentVersion'];
    this.newVersion=map['newVersion'];
    this.newVersionIntroduce=map['newVersionIntroduce'];
    this.path=map['path'];

  }
}

