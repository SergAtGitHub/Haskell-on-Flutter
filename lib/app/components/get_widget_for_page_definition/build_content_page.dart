import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/get_widget_for_page_definition/processors/build_navigation_bar.dart';
import 'package:haskell_is_beautiful/app/components/get_widget_for_page_definition/processors/build_tabs.dart';
import 'package:haskell_is_beautiful/app/components/get_widget_for_page_definition/processors/wrap_page.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildContentPage extends Pipeline {
  BuildContentPage() : super([
    BuildNavigationBar(), BuildTabs(), WrapPage()
  ]);

  Widget getPage(PageDefinition contents) {
    return this.execute<Widget>({'contents': contents})[0];
  }
}