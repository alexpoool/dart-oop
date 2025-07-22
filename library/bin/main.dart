import 'dart:io';
import 'dart:math';
import '../lib/magazine.dart';
import '../lib/objectLibrary.dart';
import '../lib/user.dart';
import '../lib/book.dart';
import '../lib/library.dart';

void main()async {
  final Library library = Library();
  
  // Cargar datos iniciales
  try {
    print('Iniciando carga de datos...');  
    await library.loadInitialData();
    library.showCataloge();
    print('Datos cargados exitosamente.\n');
  } catch (e) {
    print('Error al cargar datos: $e');
  }

  String optionMenu;
  
  do {    
    // Mostrar menú
    menu();
    
    // Leer opción del usuario
    optionMenu = stdin.readLineSync()?.trim() ?? '';
    
    // Procesar opción
    switch(optionMenu) {
      case '1':
        // Registrar usuario
        print('REGISTRAR NUEVO USUARIO\n');
        print('Nombre: ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        if (name.isNotEmpty) {
          library.registerUser(User(name: name, id: getUserID()));
          print('\nUsuario registrado con éxito.');
        } else {
          print('\nError: El nombre no puede estar vacío.');
        }
        break;
        
      case '2':
        // Buscar por ID
        print('BUSCAR POR ID\n');
        print('Ingrese el ID a buscar: ');
        final String id = stdin.readLineSync()?.trim() ?? '';
        final object = library.findObjectByID(id);
        if (object != null) {
          print('\nResultado de búsqueda:');
          object.showInfo();
        } else {
          print('\nNo se encontró ningún objeto con ese ID.');
        }
        //await pause();
        break;
        
      case '3':
        // Buscar por título
        print('BUSCAR POR TÍTULO\n');
        print('Ingrese el título a buscar: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        final object = library.findByTitle(title);
        if (object != null) {
          print('\nResultado de búsqueda:');
          object.showInfo();
        } else {
          print('\nNo se encontró ningún objeto con ese título.');
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
        Objectlibrary? magazine = library.findByTitle(title);

        if(user != null) {
          library.userReadMegazine(user, magazine as Magazine);
        } else {
          print('Usuario no registrado');
        }
        await Future.delayed(Duration(seconds: 2));
        print('Usuario: ${user?.name} leyendo ${magazine?.title}');
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
        Objectlibrary? book = library.findByTitle(title);
        
        if(user != null) {
          library.lendBook(user, book as Book);
        } else {
          print('Usuario no registrado');
        }
        await Future.delayed(Duration(seconds: 2));
        print('Usuario: ${user?.name} tiene prestado ${book?.title}');
        break;
        
      case '6':
        // Devolver Libro
      
        print('DEVOLVER LIBRO\n');
        
        print('Usuario que va a devolver : ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);

        print('Titlulo del libro a devolver: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Objectlibrary? book = library.findByTitle(title);
        
        if(user != null) {
          library.userReturnBook(user, book as Book);
        } else {
          print('Usuario no registrado');
        }
        await Future.delayed(Duration(seconds: 2));
        print('Usuario: ${user?.name} devolvio ${book?.title}');
        break;
      
      case '7':
        // Devolver Revista
      
        print('DEVOLVER REVISTA\n');
        
        print('Usuario que va a devolver : ');
        final String name = stdin.readLineSync()?.trim() ?? '';
        User? user = library.findUserByName(name);

        print('Titlulo del libro a devolver: ');
        final String title = stdin.readLineSync()?.trim() ?? '';
        Objectlibrary? magazine = library.findByTitle(title);
        
        if(user != null) {
          library.userReturnMagazine(user, magazine as Magazine);
        } else {
          print('Usuario no registrado');
        }
        await Future.delayed(Duration(seconds: 2));
        print('Usuario: ${user?.name} devolvio ${magazine?.title}');
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
        // Salir
        print('Saliendo del sistema...');
        break;
        
      default:
        print('\nOpción no válida. Por favor intente nuevamente.');
    }
  } while(optionMenu != '7');
}

void menu() {
  print(
    '''
    ++++++++++++  MENÚ PRINCIPAL  +++++++++++++++++
    (1). Registrar usuario.
    (2). Buscar Libro/Revista por ID.
    (3). Buscar Libro/Revista por Título.
    (4). Leer Revista. 
    (5). Prestrar Libro. 
    (6). Devolver Libro. 
    (7). Devolver Revista. 
    (8). Mostrar Catálogo completo.
    (9). Mostrar usuarios registrados.
    (10) Salir.
    
    Ingrese una opción: '''
  );
}

String getUserID() {
  return (Random.secure().hashCode / 100000).round().toString();
}

