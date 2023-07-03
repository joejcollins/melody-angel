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
    sample_waypoints = []
    for waypoint in gpx.waypoints:
        name = waypoint.name or ""
        latitude = waypoint.latitude or ""
        longitude = waypoint.longitude or ""
        elevation = waypoint.elevation or ""
        sample_waypoints.append(
            {
                "id": name,
                "latitude": latitude,
                "longitude": longitude,
                "elevation": elevation,
            }
        )

    # Write waypoints to CSV file
    with open(CSV_FILE, "w+", newline="") as records_file:
        record_writer = csv.DictWriter(
            records_file,
            fieldnames=[
                "id",
                "latitude",
                "longitude",
                "elevation",
                "eastings",
                "northings",
            ],
        )
        record_writer.writeheader()
        for sample_waypoint in sample_waypoints:
            sample_point = SamplePoint(**sample_waypoint)
            record_writer.writerow(sample_point.dict())
