"""Schema for a sampling point."""
from pydantic import BaseModel
from OSGridConverter import latlong2grid


class SamplePoint(BaseModel):
    """A sample point with both OS grid and the Geographic Coordinate System."""

    id: str
    latitude: float
    longitude: float
    elevation: float

    @property
    def eastings(self):
        return latlong2grid(self.latitude, self.longitude, tag="WGS84").E

    @property
    def northings(self):
        return latlong2grid(self.latitude, self.longitude, tag="WGS84").N

    def dict(self, *args, **kwargs):
        result = super().dict(*args, **kwargs)
        result['eastings'] = self.eastings
        result['northings'] = self.northings
        return result
