# Floci-Dash — Local AWS

Run a local AWS-compatible API at `http://localhost:4566` with a dashboard for managing it. Use it for dev/testing without touching real AWS and losing real money.

## Quick start

```bash
docker compose up -d
```

| Endpoint | URL |
|---|---|
| AWS API | `http://localhost:4566` |
| Dashboard | `http://localhost:3000` |

Or open in VS Code → **Reopen in Container** (uses `.devcontainer/`, brings up AWS CLI + Node and pre-configures the environment).

## Pointing AWS tooling at Floci

Any AWS SDK/CLI that respects `AWS_ENDPOINT_URL` works with no code changes. Set these (the devcontainer sets them automatically):

```bash
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```

Then use AWS as usual:

```bash
aws s3 mb s3://demo
aws s3 ls
aws sqs create-queue --queue-name jobs
aws dynamodb list-tables
```

Outside the devcontainer, either export the vars above or pass `--endpoint-url http://localhost:4566` per command.

> Credentials are dummy values — Floci accepts anything. Never point real AWS credentials at this endpoint.

## Storage

- Mode: `hybrid`, persisted to the `floci-data` volume (`FLOCI_STORAGE_PERSISTENT_PATH=/app/data`).
- Data survives `docker compose restart`; the volume is only removed by `./reset.sh` (`docker compose down -v`).

## Files

| File | Purpose |
|---|---|
| `compose.yaml` | Floci container, ports, volume, env |
| `.devcontainer/` | Dev container with AWS CLI + preconfigured endpoint |
| `reset.sh` | Tear down and wipe all local AWS state |