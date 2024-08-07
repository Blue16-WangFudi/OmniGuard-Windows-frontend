import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io'; // Import dart:io for File class
import '../pages/risk_content_identification.dart';
import '../services/tencent_cos_service.dart';
class FileProvider with ChangeNotifier {
  List<FileIcon> _fileIcons = [];
  bool uploading = false;
  List<FileIcon> get fileIcons => _fileIcons;

  bool isUploading(){
    return uploading;
  }

  void addFileIcon(FileIcon fileIcon) async {
    uploading = true;
    notifyListeners();
    await tencentCosService(fileIcon.key,fileIcon.base64Image);
    uploading = false;
    _fileIcons.add(fileIcon);
    notifyListeners();
  }
  void setFileUploadingState(bool state){
    uploading = state;
    notifyListeners();
  }
  void removeFileIcon(FileIcon fileIcon) {
    _fileIcons.remove(fileIcon);
    notifyListeners();
  }

  void clearFileIcon(){
    _fileIcons = [];
    notifyListeners();

  }

  bool isNotAllEmpty() {
    return _fileIcons.any((icon) => icon.base64Image.isNotEmpty);
  }
}


  // bool isNotAllEmpty(){
  //   return imageBase64.isNotEmpty || audioBase64.isNotEmpty || videoBase64.isNotEmpty || documentBase64.isNotEmpty;
  // }

  // List<FileIcon> _fileIcons = [];

  // List<FileIcon> get fileIcons => _fileIcons;
  
  // void addFileIcon(FileIcon fileIcon) {
  //   _fileIcons.add(fileIcon);
  //   notifyListeners();
  // }

  // void removeFileIcon(FileIcon fileIcon,) {
  //   _fileIcons.remove(fileIcon);
  //   notifyListeners();
  // }

  // bool isNotAllEmpty() {
  //   return _fileIcons.any((icon) => icon.base64Image.isNotEmpty ||
  //                            icon.base64Audio.isNotEmpty ||
  //                            icon.base64Video.isNotEmpty ||
  //                            icon.base64Document.isNotEmpty);
  // }

// }