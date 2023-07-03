""" Transform GPX into csv. """
import csv

import gpxpy

GPX_FILE = "data/raw/Waypoints_03-JUL-23.gpx"
CSV_FILE = "data/processed/hill_heights.csv"


def make_hill_heights() -> None:
    """ Use an xslt to add put the id in the gpx name element """
    # Parse GPX file
    with open(GPX_FILE, 'r') as f:
        gpx = gpxpy.parse(f)

    # Extract waypoints
    waypoints = []
    for waypoint in gpx.waypoints:
        name = waypoint.name or ''
        latitude = waypoint.latitude or ''
        longitude = waypoint.longitude or ''
        elevation = waypoint.elevation or ''
        waypoints.append([name, latitude, longitude, elevation])

    # Write waypoints to CSV file
    with open(CSV_FILE, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['name', 'latitude', 'longitude', 'elevation'])
        writer.writerows(waypoints)
