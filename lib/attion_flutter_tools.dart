library attion_flutter_tools;

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'dart:math' show Random;
import 'package:scoped_model/scoped_model.dart';

part 'pages/ThemePage.dart';
part 'utils/FileHelper.dart';
part 'utils/AppGlobalState.dart';
part 'components/SelectedButton.dart';