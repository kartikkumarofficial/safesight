import os

# Root directory (where lib folder exists)
BASE_DIR = os.path.join(os.getcwd(), "lib")

# Folder structure definition
structure = {
    "controllers": [
        "auth_controller.dart",
        "user_controller.dart",
        "model_controller.dart"
    ],
    "presentation": {
        "screens": {
            "auth": ["login_screen.dart", "signup_screen.dart"],
            "profile": ["profile_screen.dart"],
            "camera": ["cam_screen.dart"]
        },
        "widgets": []
    },
    "data": {
        "models": []
    },
    "utils": ["constants.dart"],
}

# Create main.dart at root of lib
main_file = os.path.join(BASE_DIR, "main.dart")

def create_file(path, content=""):
    """Create a file with optional default content."""
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)

def create_structure(base, struct):
    """Recursively create directories and files."""
    for key, value in struct.items():
        folder_path = os.path.join(base, key)
        os.makedirs(folder_path, exist_ok=True)

        if isinstance(value, dict):
            create_structure(folder_path, value)
        elif isinstance(value, list):
            for file in value:
                file_path = os.path.join(folder_path, file)
                create_file(file_path, f"// {file}\n")

# Create base lib folder if missing
os.makedirs(BASE_DIR, exist_ok=True)

# Create all folders and files
create_structure(BASE_DIR, structure)

# Create bindings.dart
create_file(os.path.join(BASE_DIR, "bindings.dart"), "// bindings.dart\n")

# Create main.dart with a minimal Flutter entrypoint
if not os.path.exists(main_file):
    create_file(main_file, """\
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
""")

print("✅ Flutter folder structure created successfully!")
