# Parse.ly Block

## views:

| View  |      Description    |
|----------|-------------|
| events | single wide table modeling - can potentialy remove action = 'heartbeat' event types for performance consideraitons |
| page_facts | Derived table to grab an accurate publish time for each canonical url. |
| user_facts | Derived table to aggregated information about users |
| page_engagement_facts | Derived table to aggregate information around engagement(leverages heartbeat action type and engaged_time_inc dimension) |

## References:
- [Parse.ly's Information on the Schema](https://www.parsely.com/help/rawdata/schemas/)
- [Parse.ly's Metric Guide](https://www.parsely.com/help/rawdata/metrics/)
