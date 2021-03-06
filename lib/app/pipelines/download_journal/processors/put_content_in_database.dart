import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/get_page_definition.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class PutContentInDatabase extends TryProcessor {
  @override
  Future tryExecute(PipelineContext context) async {
    var categories = (context.properties["result"] as List<Category>);

    var script = addToDatabase(categories);
    await ExecuteDatabaseCommand.instance.executeCommand(script, context.onMessage);
  }

  @override
  bool safeCondition(PipelineContext context) {
    return context.properties.containsKey("result");
  }

  Future Function(Database) addToDatabase(List<Category> categories) {
    return (Database db) async {
      // var dbCategoryList = await db.rawQuery("""
      //     SELECT *
      //     FROM category
      //     WHERE category.category = ? AND category.title = ?
      //     LIMIT 1
      //     """, [category.topic, category.title]);

      // if (dbCategoryList.isEmpty) {

      await db.transaction((txn) async {
        await txn.delete('category');
        await txn.delete('tab');
        await txn.delete('piece');
        await txn.delete(
          'sqlite_sequence',
          where: 'name IN (?, ?, ?)',
          whereArgs: ['category', 'tab', 'piece'],
        );
        for (var category in categories) {
          var pageDefinition =
              await GetCategoryContent.instance.getContent(category);
          var categoryId = await txn.insert('category', {
            'category': category.topic,
            'title': category.title,
            'icon': category.icon,
            'owner': 1,
          });
          for (var tab in pageDefinition.tabs) {
            var tabId = await txn
                .insert('tab', {'owner': categoryId, 'icon': tab.icon});
            for (var piece in tab.pieces) {
              await txn.insert('piece',
                  {'owner': tabId, 'type': piece.type, 'data': piece.data});
            }
          }
        }
      });
      // } else {
      //   final found = SqlCategory.fromMap(dbCategoryList[0]);
      //   if (found.updated?.add(Duration(days: 1))?.isBefore(DateTime.now()) ??
      //       true) {
      //     db.update(
      //         'category',
      //         {
      //           'category': category.topic,
      //           'title': category.title,
      //           'icon': category.icon,
      //           'updated': DateTime.now().toString()
      //         },
      //         where: 'id = ?',
      //         whereArgs: [found.id]);
      //   }
      // }
    };

  }
}
