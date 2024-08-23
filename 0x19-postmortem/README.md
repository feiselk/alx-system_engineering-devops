Done by : Feisel Kemal

Issue Summary
Duration: The outage occurred on August 18, 2024, from 12:30 PM to 2:00 PM SAST.
Impact: The primary web application was down, resulting in a 503 error for 85% of users. Users were unable to access core services, which included login, registration, and browsing product pages. Approximately 15% of users experienced degraded performance with slow load times instead of a complete service disruption.
Root Cause: A misconfiguration in the web server’s connection limit settings led to an overload in concurrent connections, causing the server to stop responding to user requests.

Timeline
12:30 PM: Issue detected via monitoring alerts from Datadog indicating a spike in server response times and HTTP 503 errors.
12:32 PM: An engineer confirmed the issue after reviewing the Datadog metrics showing connection drops across the web server.
12:35 PM: Initial investigation started by reviewing recent deployments and checking the database for potential issues.
12:45 PM: Assumed the issue was related to the database due to high query load, but after reducing queries, the issue persisted.
1:00 PM: Incident escalated to the web server team for further analysis.
1:10 PM: Discovered the root cause in the web server’s configuration settings, which limited the number of concurrent connections.
1:15 PM: Misleading path investigated earlier involved assuming the database was overwhelmed due to a coincidental peak in traffic.
1:30 PM: Configuration file was corrected to increase the limit on concurrent connections, and the web server was restarted.
2:00 PM: Full service restored, and normal operations resumed.

Root Cause and Resolution
The root cause of the outage was a misconfigured web server setting that restricted the maximum number of concurrent connections. The server was configured to only allow a certain number of simultaneous connections. However, as user traffic increased, this limitation was reached quickly, causing the server to stop accepting new connections and leading to HTTP 503 errors for most users.
Upon escalating the issue to the web server team, they identified that the max_connections setting in the Nginx configuration was set too low to handle the current traffic load. After adjusting the setting to a higher value and restarting the server, the issue was resolved, and users could access the services without any further disruptions



Corrective and Preventative Measures
To prevent this issue from reoccurring, the following actions will be taken:
Increase Connection Limits: Update the connection limit settings on the web server to handle higher volumes of traffic and ensure that future peaks do not overload the system.
TODO: Modify nginx.conf to increase worker_connections and worker_rlimit_nofile.
Add Load Testing: Implement load testing to simulate high-traffic scenarios to identify potential configuration issues before they occur in production.
TODO: Use tools like JMeter to perform regular load testing.
Monitor Key Metrics: Enhance the monitoring for connection limits and alert the team when usage reaches 80% of the limit.
TODO: Create Datadog monitors for Nginx worker_connections utilization.
Automated Alerts: Set up automatic alerts for any future spikes in server response times or 503 errors.
TODO: Create alerts in Datadog for response times exceeding acceptable thresholds.
Routine Configuration Audits: Schedule routine audits of server configurations to ensure they align with the expected traffic loads.
TODO: Establish a monthly review process of critical configurations such as Nginx settings




