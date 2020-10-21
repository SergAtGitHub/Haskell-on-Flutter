

import 'dart:io';

import 'package:haskell_is_beautiful/app/entities/content_piece.dart';

// Tab
class TabDefinition {
  final String icon;
  final List<ContentPiece> pieces;

  TabDefinition(this.pieces, {this.icon});

  List<String> getAll(ContentType contentType) {
    return pieces.where((element) => element.type == contentType).map((e) => e.data);
  }
  
  String getOne(ContentType contentType) {
    var element = pieces.firstWhere((element) => element.type == contentType, orElse: () => null);
    if (element == null) {
      return null;
    }

    return element.data;
  }
}