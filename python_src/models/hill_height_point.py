"""Schema for a sampling point."""
from pydantic import BaseModel


class SamplePoint(BaseModel):
    """A sample point with both OS grid and the Geographic Coordinate System."""
    id: int
    description: str
    eastings: int
    northings: int
    latitude: float
    longitude: float
    os_grid_ref: str
