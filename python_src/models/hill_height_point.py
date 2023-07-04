"""Schema for a sampling point."""
from typing import Any

from OSGridConverter import latlong2grid
from pydantic import BaseModel


class SamplePoint(BaseModel):
    """A sample point with both OS grid and the Geographic Coordinate System."""

    name: str
    latitude: float
    longitude: float
    elevation: float

    @property
    def eastings(self) -> int:
        os_grid_reference = latlong2grid(self.latitude, self.longitude, tag="WGS84")
        return int(os_grid_reference.E)

    @property
    def northings(self) -> int:
        os_grid_reference = latlong2grid(self.latitude, self.longitude, tag="WGS84")
        return int(os_grid_reference.N)

    def dict(self, *args, **kwargs) -> Any:
        result = super().model_dump(*args, **kwargs)
        result["eastings"] = self.eastings
        result["northings"] = self.northings
        return result
