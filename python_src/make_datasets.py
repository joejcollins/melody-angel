"""Create the datasets."""
from python_src.handlers.hill_heights import make_hill_heights


def create_hill_heights_table() -> None:
    """Create the hill_heights table."""
    make_hill_heights()


if __name__ == "__main__":
    create_hill_heights_table()
    print("Done")
