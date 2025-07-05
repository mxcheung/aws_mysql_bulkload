import csv
from datetime import datetime, timedelta

with open('data.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['id', 'name', 'email', 'created_at'])
    base_date = datetime.now()

    for i in range(1, 1_000_001):
        delta_days = i % 3650  # stays within last ~10 years
        created_at = base_date - timedelta(days=delta_days)
        writer.writerow([
            i,
            f'User{i}',
            f'user{i}@example.com',
            created_at.strftime('%Y-%m-%d %H:%M:%S')
        ])
