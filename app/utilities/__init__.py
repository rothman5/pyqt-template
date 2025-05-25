from pathlib import Path

PROJECT_PATH = Path(__file__).parent.parent.parent
RESOURCES_PATH = PROJECT_PATH / "resources"

if __name__ == "__main__":
    print(f"PROJECT_PATH: {PROJECT_PATH}")
    print(f"RESOURCES_PATH: {RESOURCES_PATH}")
