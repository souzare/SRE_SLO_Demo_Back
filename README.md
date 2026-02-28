# SRE SLO Demo -- Backup Environment (V2)

## Purpose

This environment is an isolated backup stack to ensure demo continuity
in case of failure during live sessions.

Namespace: - `sre-v2.local`

Services: - `sre-app-v2-service` - `sre-observability-v2-service`

------------------------------------------------------------------------

# Step 1 -- Build and Push V2 Images

``` bash
./build-and-push-v2.sh
```

------------------------------------------------------------------------

# Step 2 -- Deploy V2 Stack

``` bash
./deploy-v2.sh
```

Stack name:

    sre-slo-demo-v2

------------------------------------------------------------------------

# Step 3 -- Validate Targets

    http://<OBSERVABILITY_V2_IP>:9090/targets

Expect:

    sre-app-v2-service.sre-v2.local:5000 → UP

------------------------------------------------------------------------

# Step 4 -- Configure Grafana

    http://<OBSERVABILITY_V2_IP>:3000

Datasource URL:

    http://localhost:9090

------------------------------------------------------------------------

# Dashboard Configuration

## SLI Query

``` promql
sum(rate(http_requests_total{http_status=~"2.."}[5m]))
/
clamp_min(sum(rate(http_requests_total[5m])), 0.00001)
```

Unit: - Percent (0-1)

------------------------------------------------------------------------

# Demo Flow

1.  Generate normal traffic
2.  Observe 100% success
3.  Generate failures via `/fail`
4.  Observe SLI drop
5.  Kill app container
6.  Show automatic recovery via ECS + Cloud Map

------------------------------------------------------------------------

# Backup Strategy

This stack allows:

-   Independent environment testing
-   Safe experimentation
-   Fallback during live classes

------------------------------------------------------------------------

# Final Reminder

Always have a Plan B before running a live infrastructure demo.
