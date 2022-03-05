
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final _dbName= 'mydatabase.db';
  static final _dbVersion= 1;
  static final _tableName='myTable';
  static final columnId='_id';
  static final columnName='name';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance= DatabaseHelper._privateConstructor();
  static Database?  _database;
  Future<Database?> get database async{
    if(_database!=null) return _database;
    _database=await _inititateDatabase();
     return _database;

  }

  _inititateDatabase() async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path= join(directory.path,_dbName);
    return await openDatabase(path,version: _dbVersion,onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    db.execute('''
        CREATE TABLE _tableName(columnId INTEGER PRIMARY KEY,
        columnName String NOT NULL)
        
        '''


    );
  }

  Future<List<Map<String, dynamic>>?> queryAll() async{
    Database? db=await instance.database;
    return await db?.query(_tableName);
  }
}