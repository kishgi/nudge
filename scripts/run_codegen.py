import subprocess
import shutil
import os

def main():
    # 1. Back up pubspec.yaml
    print("Backing up pubspec.yaml...")
    shutil.copy('pubspec.yaml', 'pubspec.yaml.bak')

    try:
        # Read pubspec
        with open('pubspec.yaml', 'r') as f:
            content = f.read()

        # We want to add isar_generator and build_runner to dev_dependencies and dependency_overrides.
        dev_deps_section = """dev_dependencies:
  build_runner: 2.4.6
  isar_generator: 3.1.0+1
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0"""
        
        overrides_section = """dependency_overrides:
  analyzer: 5.13.0
  build_resolvers: 2.4.2
  dart_style: 2.3.1"""

        # Replace dev_dependencies
        new_content = content.replace("dev_dependencies:\n  flutter_test:\n    sdk: flutter\n  flutter_lints: ^6.0.0", dev_deps_section)
        new_content += "\n" + overrides_section + "\n"

        with open('pubspec.yaml', 'w') as f:
            f.write(new_content)

        print("Running flutter pub get with code generation dependencies...")
        subprocess.run(['flutter', 'pub', 'get'], check=True)

        print("Running codegen...")
        # Executing the entrypoint directly as in Phase 1
        subprocess.run(['dart', 'run', '.dart_tool/build/entrypoint/build.dart', 'build', '--delete-conflicting-outputs'], check=True)
        print("Codegen complete.")

    except Exception as e:
        print(f"Error during code generation: {e}")

    finally:
        print("Restoring pubspec.yaml...")
        shutil.copy('pubspec.yaml.bak', 'pubspec.yaml')
        if os.path.exists('pubspec.yaml.bak'):
            os.remove('pubspec.yaml.bak')
        print("Running flutter pub get to restore standard dependencies...")
        subprocess.run(['flutter', 'pub', 'get'], check=True)
        print("Restored.")

if __name__ == "__main__":
    main()
