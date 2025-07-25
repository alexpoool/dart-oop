import 'dart:io';
import 'dart:math';
import '../lib/error.dart';
import '../lib/magazine.dart';
import '../lib/user.dart';
import '../lib/book.dart';
import '../lib/library.dart';

void main() async {
  final Library library = Library();

  // Cargar datos iniciales
  try {
    print('Iniciando carga de datos...');
    await library.loadInitialData();
    library.showCataloge();
    print('Datos cargados exitosamente.\n');
  } catch (err) {
    print('Error al cargar datos: $err');
  }

  String optionMenu;

  do {
    // Mostrar menú
    menu();

    // Leer opción del usuario
    optionMenu = stdin.readLineSync()?.trim() ?? '';

    // Procesar opción
    switch (optionMenu) {
      case '1':
        // Registrar usuario
        print('REGISTRAR NUEVO USUARIO\n');
        print('Nombre: ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        if (name.isNotEmpty) {
          library.addUser(User(name: name, id: getUserID()));
          print('\nUsuario registrado con éxito.\n');
        } else {
          print('\nError: El nombre no puede estar vacío.\n');
        }
        break;

      case '2':
        // Buscar Revista por titulo
        print('\nBUSCAR REVISTA\n');
        print('\nIngrese el titulo a buscar: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Magazine? magazine = library.findMagazineByTitle(title);

        if (magazine != null) {
          print('\nResultado de búsqueda:');
          magazine.showInfo();
        } else {
          print('\nNo se encontró ninguna revista con ese titulo $title.\n');
        }
        break;

      case '3':
        // Buscar Libro por título
        print('BUSCAR BOOK\n');

        print('Ingrese el título a buscar: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Book? book = library.findBookByTitle(title);

        if (book != null) {
          print('\nResultado de búsqueda:');
          book.showInfo();
        } else {
          print('\nNo se encontró ningún libro con ese título.\n');
        }
        break;

      case '4':
        // Leer revista
        print('LEER REVISTA\n');
        print('Usuario a prestar: ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);
      
        print('Titlulo de la  revista a leer: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Magazine? magazine = library.findMagazineByTitle(title);

        try { 
          userValidate(user);
          magazineValidate(magazine);

          Future.delayed(Duration(seconds: 2));
          library.readUserMegazine(user!, magazine!);

        } on UserException catch(err) {
          print(err);
        } on ObjectException catch(err) {
          print(err);
        }

        break;

      case '5':
        // Prestar libro

        // User user;
        print('PRESTAR\n');

        print('Usuario a prestar: ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);

        print('Titlulo del libro a leer: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Book? book = library.findBookByTitle(title);
         
        try { 
          userValidate(user);
          bookValidate(book);

          Future.delayed(Duration(seconds: 2));
          library.lendBookUser(user!, book!);

        } on UserException catch(err) {
          print(err);
        } on ObjectException catch(err) {
          print(err);
        }

        break;

      case '6':
        // Devolver Libro

        print('\nDEVOLVER LIBRO');

        print('Usuario que va a devolver : ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);

        print('Titlulo del libro a devolver: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Book? book = library.findBookByTitle(title);

        try { 
          userValidate(user);
          bookValidate(book);

          Future.delayed(Duration(seconds: 2));
          library.returnUserBook(user!, book!);

        } on UserException catch(err) {
          print(err);
        } on ObjectException catch(err) {
          print(err);
        }

        break;

      case '7':
        // Devolver Revista

        print('DEVOLVER REVISTA\n');

        print('Usuario que va a devolver : ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);

        print('Titlulo del libro a devolver: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Magazine? magazine = library.findMagazineByTitle(title);

          try { 
          userValidate(user);
          magazineValidate(magazine);

          Future.delayed(Duration(seconds: 2));
          library.returnUserMagazine(user!, magazine!);

        } on UserException catch(err) {
          print(err);
        } on ObjectException catch(err) {
          print(err);
        }

        break;

      case '8':
        // Mostrar catálogo completo

        print('CATÁLOGO COMPLETO\n');
        library.showCataloge();
        break;

      case '9':
        // Mostrar usuarios
        print('USUARIOS REGISTRADOS\n');
        library.showUsers();
        break;

      case '10':
        // Mostrar historial de usuario
        print('MOSTRAR HISTORIAL DE USUARIO\n');

        print('Nombre de usuario: ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);
        
        try { 
          userValidate(user);  
        } on UserException catch(err) {
          print(err);
        } 

        if(user != null) {
          print('\nBOOKS');
          if(user.lentBooks.isNotEmpty){
            for(var book in user.lentBooks){
              book.showHistorial();
            }
          } else {
            print('Usuario $name no tiene libros prestados\n');
          }

          print('\nMAGAZINES');
          if(user.lentMagazines.isNotEmpty){
            for(var magazine in user.lentMagazines){
              magazine.showHistorial();
            }
          } else {
            print('Usuario $name no esta leyendo revistas\n');
          }
        } else {
          print('Usuario $name no está registrado\n');
        }

        break;

      case '11':
        // Salir
        print('Saliendo del sistema...\n');
        break;

      default:
        print('\nOpción no válida. Por favor intente nuevamente.\n');
    }
  } while (optionMenu != '7');
}

void menu() {
  print('''
    ++++++++++++  MENÚ PRINCIPAL  +++++++++++++++++
    (1). Registrar usuario.
    (2). Buscar Revista por Título.
    (3). Buscar Libro por Título.
    (4). Leer Revista. 
    (5). Prestrar Libro. 
    (6). Devolver Libro. 
    (7). Devolver Revista. 
    (8). Mostrar Catálogo completo.
    (9). Mostrar usuarios registrados.
    (10). Mostrar historial de usuario.
    (11). Salir.
    
    Ingrese una opción: ''');
}

String getUserID() {
  return (Random.secure().hashCode / 100000).round().toString();
}

void userValidate(User? user) {
  if(user == null ){
    throw UserException('Usuario no encontrado');
  }
}

void bookValidate(Book? book) {
  if(book == null) {
    throw ObjectException('Libro no encontado');
  }
}

void magazineValidate(Magazine? magazine) {
  if(magazine == null) {
    throw ObjectException('Revista no encontrada');
  }
}