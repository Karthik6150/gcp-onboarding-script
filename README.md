# CGuard GCP Onboarding

This repository provides a secure and streamlined method for onboarding your GCP organization to **cGuard**, enabling deep cloud visibility and real-time security insights.

---

## What This Script Does

- Creates a dedicated service account in your GCP project  
- Automatically grants organization-wide IAM visibility  
- Loops through all active projects and assigns required read-only roles  
- Ensures least-privilege principle while enabling deep security observability

---

## Roles Granted

### Organization-Level

| Role                                      | Purpose                                |
|-------------------------------------------|----------------------------------------|
| `roles/resourcemanager.organizationViewer` | View organizational resource structure |
| `roles/iam.organizationRoleViewer`         | View organization-wide IAM roles       |

### Project-Level

| Role                                  | Purpose                                 |
|---------------------------------------|-----------------------------------------|
| `roles/viewer`                        | Read-only access to project resources   |
| `roles/cloudasset.viewer`            | Access Cloud Asset Inventory            |
| `roles/logging.viewer`               | View logs (Audit, Admin Activity)       |
| `roles/monitoring.viewer`            | View monitoring metrics                 |
| `roles/securitycenter.viewer`        | View Security Command Center findings   |
| `roles/iam.securityReviewer`         | View IAM bindings and policies          |
| `roles/iam.roleViewer`               | View IAM roles                          |
| `roles/iam.serviceAccountViewer`     | View service accounts and keys          |

---

## Prerequisites

- You must be an **Organization Admin** or **Project Owner**
- `gcloud` CLI must be installed (Cloud Shell is recommended)
- You must know your **Organization ID** and **Project ID** where the service account will be created

---

## Setup Instructions

1. Open your [GCP Cloud Shell](https://shell.cloud.google.com)
2. Copy and run the following command:

```bash
bash <(curl -s https://raw.githubusercontent.com/Karthik6150/gcp-onboarding-script/main/gcp_onboard_cguard.sh)
