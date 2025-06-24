#!/bin/bash

# CONFIG
SERVICE_ACCOUNT_NAME="cguard-onboarding-service"
PROJECT_ID="cguard-gcp" 
ORG_ID="242366378115"  

# SERVICE ACCOUNT EMAIL
SERVICE_ACCOUNT_EMAIL="$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com"

echo "Creating service account: $SERVICE_ACCOUNT_NAME in project $PROJECT_ID..."
gcloud iam service-accounts create "$SERVICE_ACCOUNT_NAME" \
  --project="$PROJECT_ID" \
  --display-name="cGuard GCP Scanner"

# ORGANIZATION-LEVEL ROLES 
ORG_ROLES=(
  roles/resourcemanager.organizationViewer
  roles/iam.organizationRoleViewer
)

echo "Assigning organization-level roles..."
for ROLE in "${ORG_ROLES[@]}"; do
  echo "Granting $ROLE to $SERVICE_ACCOUNT_EMAIL"
  gcloud organizations add-iam-policy-binding "$ORG_ID" \
    --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
    --role="$ROLE"
done

#PROJECT-LEVEL ROLES
PROJECT_ROLES=(
  roles/viewer
  roles/cloudasset.viewer
  roles/logging.viewer
  roles/monitoring.viewer
  roles/securitycenter.viewer
  roles/iam.securityReviewer
  roles/iam.roleViewer
  roles/iam.serviceAccountViewer
)

echo "Fetching all ACTIVE projects under org $ORG_ID..."
PROJECT_IDS=$(gcloud projects list --filter="lifecycleState:ACTIVE" --format="value(projectId)")

echo "Assigning project-level roles to $SERVICE_ACCOUNT_EMAIL..."
for PID in $PROJECT_IDS; do
  echo "Working on project: $PID"
  for ROLE in "${PROJECT_ROLES[@]}"; do
    echo "Granting $ROLE"
    gcloud projects add-iam-policy-binding "$PID" \
      --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
      --role="$ROLE"
  done
done

echo "GCP onboarding complete!"
echo "Service Account: $SERVICE_ACCOUNT_EMAIL"
