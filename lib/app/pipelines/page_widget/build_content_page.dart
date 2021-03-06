import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/page_widget/processors/build_navigation_bar.dart';
import 'package:haskell_is_beautiful/app/pipelines/page_widget/processors/build_tabs.dart';
import 'package:haskell_is_beautiful/app/pipelines/page_widget/processors/wrap_page.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildContentPage extends Pipeline {
  BuildContentPage() : super([
    BuildNavigationBar(), BuildTabs(), WrapPage()
  ]);

  Widget getPage(PageDefinition contents, BuildContext buildContext) {
    var result = this.execute<Widget>({'contents': contents, 'buildContext': buildContext});
    return result;
  }
}