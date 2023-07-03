"""Dummy demonstration test."""


def test_nothing() -> None:
    """Test that the static settings are correct."""
    # Arrange
    number: int = 0
    # Act
    number = 1 + 2
    number -= 2
    # ASSERT
    assert number == 1
