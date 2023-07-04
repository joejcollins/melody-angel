""" Transform GPX into csv. """
import csv
from python_src.models.hill_height_point import SamplePoint

import gpxpy

GPX_FILE = "data/raw/Waypoints_03-JUL-23.gpx"
CSV_FILE = "data/processed/hill_heights.csv"


def make_hill_heights() -> None:
    """Use an xslt to add put the id in the gpx name element"""
    # Parse GPX file
    with open(GPX_FILE, "r") as f:
        gpx = gpxpy.parse(f)
    # Extract waypoints
    sample_points = _get_sample_points(gpx)
    # Write waypoints to CSV file
    _write_sample_points_csv(sample_points)


def _get_sample_points(gpx: gpxpy.gpx.GPX) -> list[SamplePoint]:
    """Extract sample points from GPX file."""
    sample_points = []
    for gpx_waypoint in gpx.waypoints:
        name = gpx_waypoint.name or ""
        latitude = gpx_waypoint.latitude or 0.0
        longitude = gpx_waypoint.longitude or 0.0
        elevation = gpx_waypoint.elevation or 0.0
        sample_point = SamplePoint(
            name=name, latitude=latitude, longitude=longitude, elevation=elevation
        )

        sample_points.append(sample_point)
    return sample_points


def _write_sample_points_csv(sample_points) -> None:
    with open(CSV_FILE, "w+", newline="") as records_file:
        record_writer = csv.DictWriter(
            records_file,
            fieldnames=[
                "name",
                "latitude",
                "longitude",
                "elevation",
                "eastings",
                "northings",
            ],
        )
        record_writer.writeheader()
        for sample_point in sample_points:
            record_writer.writerow(sample_point.dict())
