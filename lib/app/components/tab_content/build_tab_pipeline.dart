import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/build_elements.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/wrap_tab.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/entities/content.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildTabPipeline extends Pipeline {
  BuildTabPipeline() : super([BuildElements(), WrapTab()]);

  Widget getTab(ContentData data) {
    return this.execute<Widget>({'data': data})[0];
  }
}
