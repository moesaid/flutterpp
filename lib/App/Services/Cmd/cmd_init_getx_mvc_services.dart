import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/file_gen_getx_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/vs_code_provider.dart';
import 'package:flutterpp/App/Providers/Yaml/yaml_provider.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';

class CmdInitGetxMvcServices {
  final VsCodeProvider _vsCode = VsCodeProvider();
  final CmdReadCreateDirServices _cmdRCD = CmdReadCreateDirServices();
  final CmdFlutterProvider _cmdF = CmdFlutterProvider();
  final YamlProvider _ymal = YamlProvider();
  final FileGenGetxProvider _fileGen = FileGenGetxProvider();

  // init
  Future<void> init(String path) async {
    // get name space
    String nameSpace = await _ymal.getNameSpace('$path/pubspec.yaml');

    // create vs code settings
    await _vsCode.vsCodeSettingsGen(path);

    // create configration files
    await _cmdRCD.configDefaultAnalysisOptions(path);
    await _cmdRCD.createDefultFlutterppYaml(path);

    // install dependencies
    // await _cmdF.runFlutterPubCommand(path, ['add', 'get']);
    // await _cmdF.runFlutterPubCommand(path, ['add', 'get_storage']);
    // await _cmdF.runFlutterPubCommand(path, ['add', 'freezed_annotation']);
    // await _cmdF.runFlutterPubCommand(path, ['add', 'json_annotation']);

    // dev dependencies
    // await _cmdF.runFlutterPubCommand(path, ['add', 'dev:build_runner']);
    // await _cmdF.runFlutterPubCommand(path, ['add', 'dev:freezed']);
    // await _cmdF.runFlutterPubCommand(path, ['add', 'dev:json_serializable']);

    // create default files
    await createProjectStructure(path);

    // generate Counter case
    await createCounterCase(nameSpace, path);

    // dart fix
    await _cmdF.runDartCommand(path, ['fix', '--apply']);
    await _cmdF.runDartCommand(path, ['format', '.']);
  }

  // create project structure
  Future<void> createProjectStructure(String path) async {
    await _cmdRCD.createDirectory('$path/lib/App/Controllers');
    await _cmdRCD.createDirectory('$path/lib/App/Enums');
    await _cmdRCD.createDirectory('$path/lib/App/Providers');
    await _cmdRCD.createDirectory('$path/lib/App/Services');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Atoms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Molecules');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Organisms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Layouts');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Pages/Counter/Widgets');
    await _cmdRCD.createDirectory('$path/lib/Config/Bindings');
    await _cmdRCD.createDirectory('$path/lib/Config/Exernal');
    await _cmdRCD.createDirectory('$path/lib/Config/Theme');
    await _cmdRCD.createDirectory('$path/lib/Helpers');
    await _cmdRCD.createDirectory('$path/lib/Middlewares');
    await _cmdRCD.createDirectory('$path/lib/Routes');
    await _cmdRCD.createDirectory('$path/lib/Storage');
  }

  // create counter case
  createCounterCase(String nameSpace, String path) async {
    String controllerPath = '$path/lib/App/Controllers';
    String pagePath = '$path/lib/App/Views/Pages';

    // main
    await _fileGen.mainGen(nameSpace, path);

    // remove Test folder
    await _fileGen.removeTestFolder(path);

    // routes
    await _fileGen.appRoutesGen('$path/lib/Routes');
    await _fileGen.appPagesGen(nameSpace, '$path/lib/Routes');

    // app binding
    await _fileGen.bindingGen(nameSpace, '$path/lib/Config/Bindings');

    // initlaizer
    await _fileGen.appInitializerGen('$path/lib/Config/Exernal');

    // themes
    await _fileGen.appThemeGen('$path/lib/Config/Theme');

    // create directories
    await _cmdRCD.createDirectory('$controllerPath/Counter');
    await _cmdRCD.createDirectory('$controllerPath/Home');
    await _cmdRCD.createDirectory('$controllerPath/Auth');
    await _cmdRCD.createDirectory('$pagePath/Counter');
    await _cmdRCD.createDirectory('$pagePath/Home');
    await _cmdRCD.createDirectory('$pagePath/Auth');

    // create controller
    await _fileGen.controllerGen('counter', '$controllerPath/Counter');
    await _fileGen.controllerGen('home', '$controllerPath/Home');
    await _fileGen.controllerGen('splash', '$controllerPath/Auth');

    // create page
    await _fileGen.pageGen(nameSpace, 'counter', '$pagePath/Counter');
    await _fileGen.pageGen(nameSpace, 'home', '$pagePath/Home');
    await _fileGen.pageGen(nameSpace, 'splash', '$pagePath/Auth',
        custom: 'auth');
  }
}
